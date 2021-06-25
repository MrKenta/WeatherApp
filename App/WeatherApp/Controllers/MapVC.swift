//
//  MapVC.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/7/21.
//

import UIKit
import GoogleMaps
import EDColor

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var clearButton: UIButton!
    var viewSuggestion = Suggestion()
    var isFirstLaunch = true
    var avalibleData = [InfoForUser]()
    
    var loactionManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        clearButton.layer.cornerRadius = clearButton.bounds.height / 2
        clearButton.layer.borderWidth = 0.3
        clearButton.layer.borderColor = UIColor.black.cgColor
        clearButton.backgroundColor = UIColor.init(crayola:"Maroon")
        clearButton.setTitleColor(UIColor.black, for: .normal)
        view.bringSubviewToFront(clearButton)
        loactionManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch isFirstLaunch {
        case true:
            viewSuggestion.frame = CGRect(x:0, y:0, width:250, height:100)
            viewSuggestion.alpha = 0
        
            viewSuggestion.textLabel.text = "Hello!!! To get weather data just touch to map. Then tap to marker. Enjoy!!!"
            viewSuggestion.layer.cornerRadius = 25
            view.addSubview(viewSuggestion)
            let timer = Timer.scheduledTimer(withTimeInterval:5, repeats:false) { (timer) in
                UIView.animate(withDuration:3) { [weak self] in
                    self?.viewSuggestion.center = self?.view.center ?? CGPoint(x:200, y:50)
                    self?.viewSuggestion.alpha = 1
                }
            }
            isFirstLaunch = false
        default:
            break
        }
    }
    
    
    func createMarker(coordinate:CLLocation) -> GMSMarker {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude:coordinate.coordinate.latitude, longitude:coordinate.coordinate.longitude))
        let serverData = ServerReqest()
        serverData.lat = coordinate.coordinate.latitude
        serverData.lon = coordinate.coordinate.longitude
        NetworkManager.shared.getWeather(data: serverData) { (ServerResponse) in
            print("Sucsses")
            guard let param = ServerResponse.wearher.first,
                  let feelTemp = ServerResponse.info?.feelsTemperature,
                  let pressure = ServerResponse.info?.pressure,
                  let humidity = ServerResponse.info?.humidity,
                  let windSpeed = ServerResponse.windParam?.windSpeed,
                  let windDir = ServerResponse.windParam?.windDirection,
                  let temp = ServerResponse.info?.temperature,
                  let place = ServerResponse.namePlace,
                  let country = ServerResponse.system?.country else {
                print("Something went wrong")
                return
            }
            let userInfo = InfoForUser()
            userInfo.sky = param.sky
            userInfo.skyState = param.skyDescription
            userInfo.temperature = temp
            userInfo.country = country
            userInfo.feelsTemperature = feelTemp
            userInfo.pressure = pressure
            userInfo.humidity = humidity
            userInfo.windSpeed = Int(windSpeed)
            userInfo.windDirection = windDir
            userInfo.lat = coordinate.coordinate.latitude
            userInfo.lon = coordinate.coordinate.longitude
            userInfo.place = place
            let date = NSDate()
            let calendar = NSCalendar.current
            let year = calendar.component(.year, from: date as Date)
            let day = calendar.component(.day , from:date as Date)
            let hour = calendar.component(.hour, from: date as Date)
            let minute = calendar.component(.minute, from:date as Date)
            userInfo.createDate = "\(year).\(day).\(hour).\(minute)"
            DataManager.shared.writeObject(item:userInfo)
        } failure: { (error) in
            print(error)
        }
        return marker
    }
    
    func changeCamera(coordinate:CLLocation) {
        let camera = GMSCameraPosition(latitude:coordinate.coordinate.latitude, longitude:coordinate.coordinate.longitude, zoom: 25)
        mapView.camera = camera
        
    }

    
    
    @IBAction func clearActrion(_ sender: Any) {
        mapView.clear()
    }
    
    
}

extension MapVC : GMSMapViewDelegate, CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentPosition = locations.last else {return}
        loactionManager.stopUpdatingLocation()
        changeCamera(coordinate:currentPosition)
        
    }
    
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        createMarker(coordinate:CLLocation(latitude:coordinate.latitude, longitude:coordinate.longitude)).map = mapView
        print(coordinate)
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        avalibleData = DataManager.shared.readObjects()
        
        let infoWindow = MarkerInfoWindow(frame:CGRect(x:0, y: 0, width:250, height:60))
        
        guard let temp = avalibleData.last?.temperature else { return nil }
        
        switch temp {
        case 0 ... 100:
            infoWindow.tempLabel.text = "+\(temp)"
        case -1 ... -100:
            infoWindow.tempLabel.text = "-\(temp)"
        default:
            break
        }
        
        if let place = avalibleData.last?.place,
           let country = avalibleData.last?.country{
            infoWindow.placeLabel.text = "\(place),"
            infoWindow.coutryLabel.text = country
        }
        
        switch avalibleData.last?.sky {
        case "Clear":
            infoWindow.skyImage.image = UIImage(named:"sun")
        case "Rain":
            infoWindow.skyImage.image = UIImage(named:"rain")
        case "Snow":
            infoWindow.skyImage.image = UIImage(named:"snow")
        case "Clouds":
            infoWindow.skyImage.image = UIImage(named:"strongcloiuds")
        case "few clouds":
            infoWindow.skyImage.image = UIImage(named:"suncloud")
        case "broken clouds":
            infoWindow.skyImage.image = UIImage(named:"suncloud")
        default:
            break
        }
        return infoWindow
        
    }
}

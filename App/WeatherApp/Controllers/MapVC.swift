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
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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
            DataSource.shared.data.append(userInfo)
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
        
        let infoWindow = UIView(frame:CGRect(x:0, y:0, width:200, height:30))
        infoWindow.layer.cornerRadius = infoWindow.bounds.height / 2
        infoWindow.backgroundColor = .white
    
        let textLabel = UILabel(frame: CGRect(x:35, y:0, width:200, height:30))
        
        switch DataSource.shared.data.last!.temperature {
        case 0...100:
            textLabel.text = "+\(DataSource.shared.data.last!.temperature),\(DataSource.shared.data.last!.place) "
        case -100...0:
            textLabel.text = "-\(DataSource.shared.data.last!.temperature),\(DataSource.shared.data.last!.place) "
        default:
            textLabel.text = "\(DataSource.shared.data.last!.temperature),\(DataSource.shared.data.last!.place) "
        }
        textLabel.lineBreakMode = .byTruncatingTail
        
        let img = UIImageView(frame:CGRect(x:5, y:0, width:30, height:30))
        switch DataSource.shared.data.last!.sky {
        case "Clear":
            img.image = UIImage(named:"sun")
        case "Rain":
            img.image = UIImage(named:"rain")
        case "Snow":
            img.image = UIImage(named:"snow")
        case "Clouds":
            img.image = UIImage(named:"strongcloiuds")
        case "few clouds":
            img.image = UIImage(named:"suncloud")
        case "broken clouds":
            img.image = UIImage(named:"suncloud")
        default:
            break
        }
        infoWindow.addSubview(img)
        infoWindow.addSubview(textLabel)
        
        return infoWindow
    }
}

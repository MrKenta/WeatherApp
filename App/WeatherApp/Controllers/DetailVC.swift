//
//  DetailVC.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/13/21.
//

import UIKit
import GoogleMaps

class DetailVC: UIViewController {
    
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var skyLabel: UILabel!
    @IBOutlet weak var temLabel: UILabel!
    @IBOutlet weak var feelTemp: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidtyLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirecLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    var sample : InfoForUser!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Info"
        mapView.layer.cornerRadius = 10
        requestLabel.text = "Request from \(sample.createDate)"
        setStackLabel()
        setMapParametr()
        setButton()
        
        navigationController?.navigationBar.isHidden = false
    }
    

    func setMapParametr() {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude:sample.lat, longitude:sample.lon))
        marker.title = sample.country
        marker.map = mapView
        
        let camera = GMSCameraPosition(latitude:sample.lat, longitude:sample.lon, zoom: 15)
        mapView.camera = camera
        
    }
    
    
    func setButton()  {
        exitButton.layer.cornerRadius = exitButton.bounds.height / 2
        exitButton.backgroundColor = UIColor.init(crayola:"Maroon")
        exitButton.setTitle("EXIT", for:.normal)
        exitButton.setTitleColor(UIColor.black, for:.normal)
    }
    
    func setStackLabel() {
        skyLabel.text = "Sky: \(sample.skyState)"
        if sample.temperature >= 0 {
            temLabel.text = "Temperature: +\(sample.temperature)"
        }else{
            temLabel.text = "Temperature: -\(sample.temperature)"
        }
        if sample.feelsTemperature >= 0 {
            feelTemp.text = "Feels like: +\(sample.feelsTemperature)"
        }else{
            feelTemp.text = "Feels like: -\(sample.feelsTemperature)"
        }
        pressureLabel.text = "Pressure:\(sample.pressure) nPA"
        humidtyLabel.text = "Humidty:\(sample.humidity)%"
        
        windSpeedLabel.text = "Wind speep: \(sample.windSpeed) m/s"
        
        switch sample.windDirection {
        case 0...30:
            windDirecLabel.text = "Wind direction: North Wind"
        case 31...60:
            windDirecLabel.text = "Wind direction: North-East Wind"
        case 61...120:
            windDirecLabel.text = "Wind direction: East Wind"
        case 121...150:
            windDirecLabel.text = "Wind direction: South-East Wind"
        case 151...210:
            windDirecLabel.text = "Wind direction: South Wind"
        case 211...240:
            windDirecLabel.text = "Wind direction: South-West Wind"
        case 241...300:
            windDirecLabel.text = "Wind direction: West Wind"
        case 301...330:
            windDirecLabel.text = "Wind direction: North-West Wind"
        case 331...359:
            windDirecLabel.text = "Wind direction: North Wind"
        default:
            break
        }
        countryLabel.text = "\(sample.place),\(sample.country)"
    }
    
    
    @IBAction func exitAction(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
}

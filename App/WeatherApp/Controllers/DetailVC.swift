//
//  DetailVC.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/13/21.
//

import UIKit
import GoogleMaps

class DetailVC: UIViewController {
    
    var index:Int?
    

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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Info"
        mapView.layer.cornerRadius = 10
        requestLabel.text = "Request from \(DataSource.shared.data[index!].createDate)"
        setStackLabel()
        setMapParametr()
        setButton()
    }
    

    func setMapParametr() {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude:DataSource.shared.data[index!].lat, longitude:DataSource.shared.data[index!].lon))
        marker.title = "\(DataSource.shared.data[index!].place),\(DataSource.shared.data[index!].country)"
        marker.map = mapView
        
        let camera = GMSCameraPosition(latitude:DataSource.shared.data[index!].lat, longitude: DataSource.shared.data[index!].lon, zoom: 15)
        mapView.camera = camera
        
    }
    
    
    func setButton()  {
        exitButton.layer.cornerRadius = exitButton.bounds.height / 2
        exitButton.backgroundColor = UIColor.init(crayola:"Maroon")
        exitButton.setTitle("EXIT", for:.normal)
        exitButton.setTitleColor(UIColor.black, for:.normal)
    }
    
    func setStackLabel() {
        skyLabel.text = "Sky: \(DataSource.shared.data[index!].skyState)"
        if DataSource.shared.data[index!].temperature >= 0 {
            temLabel.text = "Temperature: +\(DataSource.shared.data[index!].temperature)"
        }else{
            temLabel.text = "Temperature: -\(DataSource.shared.data[index!].temperature)"
        }
        if DataSource.shared.data[index!].feelsTemperature >= 0 {
            feelTemp.text = "Feels like: +\(DataSource.shared.data[index!].feelsTemperature)"
        }else{
            feelTemp.text = "Feels like: -\(DataSource.shared.data[index!].feelsTemperature)"
        }
        pressureLabel.text = "Pressure:\(DataSource.shared.data[index!].pressure) nPA"
        humidtyLabel.text = "Humidty:\(DataSource.shared.data[index!].humidity)%"
        
        windSpeedLabel.text = "Wind speep: \(DataSource.shared.data[index!].windSpeed) m/s"
        
        switch DataSource.shared.data[index!].windDirection {
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
        countryLabel.text = "\(DataSource.shared.data[index!].place),\(DataSource.shared.data[index!].country)"
    }
    
    
    @IBAction func exitAction(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
}

//
//  Main Info.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/8/21.
//

import Foundation
import ObjectMapper

class MainInfo: Mappable {
    
    var temperature = 0
    var feelsTemperature = 0.0
    var minTemp = 0
    var maxTemp = 0
    var pressure = 0
    var humidity = 0
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        temperature         <- map["temp"]
        feelsTemperature    <- map["feels_like"]
        minTemp             <- map["temp_min"]
        maxTemp             <- map["temp_max"]
        pressure            <- map["pressure"]
        humidity            <- map["humidity"]
        
    }
    
    
}

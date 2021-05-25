//
//  Wind.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/8/21.
//

import Foundation
import ObjectMapper

class Wind: Mappable {
    
    var windSpeed = 0.0
    var windDirection = 0
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        windSpeed        <- map["speed"]
        windDirection    <- map["deg"]
        
    }
    
    
}

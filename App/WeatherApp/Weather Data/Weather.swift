//
//  Weather.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/8/21.
//

import Foundation
import ObjectMapper

class Weather:Mappable {
    
    var sky = ""
    var skyDescription = ""
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        sky                       <- map["main"]
        skyDescription            <- map["description"]
    }
    
}

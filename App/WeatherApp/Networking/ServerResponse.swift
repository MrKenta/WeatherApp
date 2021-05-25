//
//  ServerResponse.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/8/21.
//

import Foundation
import ObjectMapper

class ServerResponse:Mappable{
    
    var wearher : [Weather] = []
    var info : MainInfo!
    var windParam : Wind?
    var system : System?
    var cloud: Clouds?
    var namePlace : String?
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        wearher    <- map["weather"]
        info       <- map["main"]
        windParam  <- map["wind"]
        system     <- map["sys"]
        cloud      <- map["clouds"]
        namePlace  <- map["name"]
    
    }
}

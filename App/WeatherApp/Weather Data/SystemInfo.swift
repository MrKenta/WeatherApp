//
//  SystemInfo.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/8/21.
//

import Foundation
import ObjectMapper

class System:Mappable {
    
    var country = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        country      <- map["country"]
    }
}

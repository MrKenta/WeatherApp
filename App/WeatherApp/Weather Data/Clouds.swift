//
//  Clouds.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/12/21.
//

import Foundation
import ObjectMapper

class Clouds: Mappable {
    var clouds:Int?
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        clouds   <- map["all"]
    }
}

//
//  WeatherClass.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/8/21.
//

import Foundation
class ServerReqest:Encodable {
    var lat:Double?
    var lon:Double?
    var appid = "682c2d1203c9e66c5d2c34430f999ecb"
    var units = "metric"
}

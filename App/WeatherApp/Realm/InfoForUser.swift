//
//  InfoForUser.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/8/21.
//

import Foundation
import RealmSwift


class InfoForUser : Object  {
    @objc dynamic var lat = 0.0
    @objc dynamic var lon = 0.0
    @objc dynamic var sky = ""
    @objc dynamic var skyState = ""
    @objc dynamic var temperature = 0
    @objc dynamic var feelsTemperature  = 0.0
    @objc dynamic var pressure = 0
    @objc dynamic var humidity = 0
    @objc dynamic var windSpeed = 0
    @objc dynamic var windDirection = 0
    @objc dynamic var country = ""
    @objc dynamic var place = ""
    @objc dynamic var createDate = ""
    
    
}

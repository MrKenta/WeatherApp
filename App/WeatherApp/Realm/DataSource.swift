//
//  DataSource.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/12/21.
//

import Foundation

class DataSource {
    
    static let shared = DataSource()
    private init () {}
    var data = [InfoForUser]()
    
}

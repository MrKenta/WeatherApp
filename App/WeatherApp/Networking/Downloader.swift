//
//  Downloader.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/12/21.
//

import Foundation
import UIKit
class Downloader {
func downloader(country:String,completion: @escaping (Data) -> Void){
    let param = country.lowercased()
    
    guard let url = URL(string:"https://flagcdn.com/56x42/\(param).png") else { return }
    let session = URLSession.shared
    session.dataTask(with:url) { (data, response, error) in
        guard let imageData = data else {return}
        completion(imageData)
    }.resume()
}
}

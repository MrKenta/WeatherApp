//
//  WeatherResponseList.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 6/25/21.
//

import Foundation
import RealmSwift

class DataManager {
    static let shared = DataManager()
    let realm = try! Realm ()
    private init () {}
    
    
    func writeObject(item:InfoForUser) {
        try! realm.write{
            realm.add(item)
        }
    }
    
    func readObjects() -> [InfoForUser] {
        return Array(realm.objects(InfoForUser.self))
    }
    
    func removeObject(item:InfoForUser) {
        try! realm.write{
            realm.delete(item)
        }
    }
    
}

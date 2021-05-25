//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/8/21.
//

import Foundation
import Moya
import Moya_ObjectMapper

final class NetworkManager {
    private let provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin()])
    private init() {}
    
    static let shared = NetworkManager()
 
    func getWeather (data:ServerReqest,completion: @escaping (ServerResponse) -> Void, failure: @escaping (String) -> Void) {
        provider.request(.getCurrentWeather(request:data)) { (result) in
            switch result {
            case let.success(response):
                print()
                guard let weather = try? response.mapObject(ServerResponse.self) else {failure("Unknown")
                    return
            }
                completion(weather)
            case let .failure(error):
                print(error)
        }
    }
}
}

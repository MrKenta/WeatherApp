//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/8/21.
//

import Foundation
import Alamofire
import Moya

enum NetworkService {
    case getCurrentWeather (request:ServerReqest)
    
}
extension NetworkService : TargetType{
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL {
        switch self {
        default:
            return URL(string:"https://api.openweathermap.org")!
        }
    }
    
    var path: String {
        switch self {
        default:
            return "/data/2.5/weather"
        }
    }
    
    var method: Moya.Method {
        return.get
        
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        default:
            guard let params = parametrs else {
                return .requestPlain
            }
        return .requestParameters (parameters:params, encoding:parametrEncoding)
    }
    }
    
    var parametrs:[String:Any]? {
        var parametrs = [String:Any]()
        switch self {
        case .getCurrentWeather (let request):
            parametrs["lat"] = request.lat
            parametrs["lon"] = request.lon
            parametrs["appid"] = request.appid
            parametrs["units"] = request.units
        default:
            break
        }
        return parametrs
    }
    
    var parametrEncoding : ParameterEncoding{
        switch self {
        default:
            return URLEncoding.queryString
        }
    }
    
    
    }


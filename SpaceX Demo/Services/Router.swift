//
//  Router.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case fetchLaunches(page: Int)
    case fetchUpcoming
    case getDetail(flightNumber: Int)
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        let newURLRequest = urlRequest.description.removingPercentEncoding?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let convertedURL = URL(string: newURLRequest!)
        urlRequest = URLRequest(url: convertedURL!)
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: nil)
    }
    
    private var method: HTTPMethod {
        switch self {
        case .fetchLaunches, .fetchUpcoming, .getDetail:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .fetchLaunches(let page):
            return "/launches?limit=\(page)"
        case .fetchUpcoming:
            return "/launches/upcoming"
        case .getDetail(let flightNumber):
            return "/launches/\(flightNumber)"
        }
    }
    
}


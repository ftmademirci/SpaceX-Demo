//
//  API.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import Foundation
import Alamofire

typealias APICallback = (_ data: [Launch]?, _ error: String?) -> Void
typealias APIDetailCallback = (_ data: Launch?, _ error: String?) -> Void

protocol APIProvider {
    func fetchLaunches(page: Int, callback: @escaping APICallback)
    func fetchUpcoming(callback: @escaping APICallback)
    func getDetail(flightNumber: Int, callback: @escaping APIDetailCallback)

}

class API: APIProvider {
    func fetchLaunches(page: Int, callback: @escaping APICallback) {
        AF.request(Router.fetchLaunches(page: page)).responseDecodable(of: [Launch].self) { (response) in
            
            guard let launch = response.value else {
                callback(nil, response.error?.errorDescription)
                return
            }
            callback(launch, nil)
        }
    }
    
    func fetchUpcoming(callback: @escaping APICallback) {
        AF.request(Router.fetchUpcoming).responseDecodable(of: [Launch].self) { (response) in
            
            guard let launch = response.value else {
                callback(nil, response.error?.errorDescription)
                return
            }
            callback(launch, nil)
    
        }
    }
    
    func getDetail(flightNumber: Int, callback: @escaping APIDetailCallback) {
        AF.request(Router.getDetail(flightNumber: flightNumber)).responseDecodable(of: Launch.self) { (response) in
            guard let launch = response.value else {
                callback(nil, response.error?.errorDescription)
                return
            }
            callback(launch, nil)
        }
    }
}


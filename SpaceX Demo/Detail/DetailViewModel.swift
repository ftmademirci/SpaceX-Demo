//
//  DetailViewModel.swift
//  SpaceX Demo
//
//  Created by Admin on 28.11.2020.
//

import Foundation

class DetailViewModel {
    
    var api: API!
    
    var launch: Launch?
    
    init(api: API) {
        self.api = api
    }
    
    func getDetail(flightNumber: Int, success: @escaping() -> Void,
                   failure: @escaping (String?) -> Void) {
        self.api.getDetail(flightNumber: flightNumber) { (response, error) in
            if error != nil {
                failure("error on loading launch")
            } else {
                self.launch = response
                success()
            }
        }
    }
}

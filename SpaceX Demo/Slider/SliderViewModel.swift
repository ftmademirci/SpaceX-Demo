//
//  SliderViewModel.swift
//  SpaceX Demo
//
//  Created by Admin on 28.11.2020.
//

import Foundation

class SliderViewModel {
    
    var api: API!
    
    var launch: [Launch]?
    
    init(api: API) {
        self.api = api
    }

    func fetchUpcoming(success: @escaping() -> Void,
                          failure: @escaping (String?) -> Void) {
        self.api.fetchUpcoming() { [self] (response, error) in
            if error != nil {
                failure("error on loading launch")
            } else {
                self.launch = response
                success()
            }
        }
    }
    
    func getRowHeader(_ index: Int) -> Launch? {
        if let dataArray = self.launch {
            return dataArray[index]
        }
        
        return nil
    }

    func getRowCount() -> Int {
        return (self.launch != nil ? self.launch!.count : 0)
    }
}


//
//  MainViewModel.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import Foundation

class MainViewModel {
    
    var api: API!
    
    var launch: [Launch]?
    
    var page = 10
    var endOfPage = false
    var perPage = 10
    
    init(api: API) {
        self.api = api
    }
    
    func fetchLaunch(success: @escaping() -> Void,
                          failure: @escaping (String?) -> Void) {
        self.api.fetchLaunches(page: self.page) { [self] (response, error) in
            if error != nil {
                failure("error on loading launch")
            } else {
                if let launch_list = response {
                    
                    if page == 10 {
                        self.launch = launch_list
                    } else {
                        self.launch?.append(contentsOf: launch_list)
                    }
                    self.page = self.page + 10
                    
                    if launch_list.count == 0 || launch_list.count < perPage {
                        self.endOfPage = true
                    }
                    
                    success()
                } else {
                    failure("error on loading photos")
                }
            }
        }
    }
    
    func resetPagination() {
        self.page = 10
        self.endOfPage = false
    }
    
    func getNextPage(_ index: Int) -> Bool {
        if self.launch != nil && index == self.launch!.count - 3 && !endOfPage {
            return true
        } else {
            return false
        }
    }
    
    func getRowCount() -> Int {
        return (self.launch != nil ? self.launch!.count : 0)
    }
    
    func getRow(_ index: Int) -> Launch? {
        if let dataArray = self.launch {
            return dataArray[index]
        }
        
        return nil
    }
    
}


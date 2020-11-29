//
//  Constant.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import UIKit

struct Constants {
    
    static let baseUrl = "https://api.spacexdata.com/v3"
    
    //The header fields
    enum HttpHeaderField: String {
        case contentType = "Content-Type"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}

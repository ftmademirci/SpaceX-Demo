//
//  Model.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import Foundation

struct Launch: Codable {
    
    let details: String?
    let flight_number: Int?
    let launch_date_unix: Int?
    let links: Links?
    let mission_name: String?
}

struct Links: Codable {
    let mission_patch: String?
}

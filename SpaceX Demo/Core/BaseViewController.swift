//
//  BaseViewController.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import UIKit
import Kingfisher

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func dateFormatter(timestamp: TimeInterval) -> String {
        let timestampToDate = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT+3")
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = .current
        let strDate = formatter.string(from: timestampToDate)
        return strDate
    }
}

//
//  LoadingAnimation.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import Foundation
import UIKit

public class Indicator {

    public static let sharedInstance = Indicator()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()

    public init()
    {
        let wh = 50
        blurImg.frame = CGRect(x: Int(UIScreen.main.bounds.width)/2-(wh/2),
                               y: Int(UIScreen.main.bounds.height)/2-(wh/2),
                               width: wh,
                               height: wh
        )
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.7

        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .white
    }

    func showIndicator(){
        DispatchQueue.main.async( execute: {
            UIApplication.shared.keyWindow?.addSubview(self.blurImg)
            UIApplication.shared.keyWindow?.addSubview(self.indicator)
        })
    }
    func hideIndicator(){
        DispatchQueue.main.async( execute: {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        })
    }
}


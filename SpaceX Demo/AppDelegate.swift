//
//  AppDelegate.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainController = MainViewController() as UIViewController
        let navigationController = UINavigationController(rootViewController: mainController)
        navigationController.navigationBar.isTranslucent = false
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController.navigationBar.tintColor = UIColor.black
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }
}


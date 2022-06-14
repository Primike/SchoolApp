//
//  AppDelegate.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit
let appColor: UIColor = .systemCyan

 
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        //specifing that SLVC is a navigation controller
        let navigationController = UINavigationController(rootViewController: SchoolListViewController())
//        let navigationContr = UINavigationController(rootViewController: TabBarViewController())
        window?.rootViewController = navigationController
        return true
    }
}


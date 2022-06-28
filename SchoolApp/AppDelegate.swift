//
//  AppDelegate.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit
let appColor: UIColor = .systemFill


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let schoolsNavigationController = UINavigationController(rootViewController: SchoolListViewController())
        window?.rootViewController = schoolsNavigationController
        return true
    }
}

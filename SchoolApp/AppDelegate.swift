//
//  AppDelegate.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    var deviceOrientation = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return deviceOrientation
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let navigationController = UINavigationController()
        let coordinator = HomeCoordinator(navigationController: navigationController)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        window.rootViewController = navigationController
        self.window = window
        
        coordinator.start()
        
        askLocation()
        
        return true
    }
    
    func askLocation() {
        LocationManager.shared.getUserLocation { location in
            
        }
    }
}

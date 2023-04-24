//
//  AppDelegate.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 5/31/22.
//

import UIKit
import CoreLocation
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var userLocation: CLLocation?
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
        Reachability.startMonitoring()
        askLocation()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        Reachability.stopMonitoring()
    }

    func askLocation() {
        LocationManager.shared.getUserLocation { [weak self] location in
            guard let self = self else {
                return
            }
            
            self.userLocation = location
        }
    }
}

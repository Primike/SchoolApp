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
    //otherwise deinit
    var coordinator: Coordinating?
    var deviceOrientation = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return deviceOrientation
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let navigationController = UINavigationController()
        coordinator = HomeCoordinator(navigationController: navigationController)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        window.rootViewController = navigationController
        self.window = window
                
        Reachability.startMonitoring()
        coordinator?.start()
        askLocation()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        Reachability.stopMonitoring()
    }

    func askLocation() {
        LocationManager.shared.getUserLocation { [weak self] location in
            guard let self = self else { return }
            print(location)
            self.userLocation = location
        }
    }
}

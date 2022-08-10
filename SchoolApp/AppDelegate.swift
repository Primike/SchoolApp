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
//    var appCoordinator: AppCoordinator!
    
    var deviceOrientation = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return deviceOrientation
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
//        self.appCoordinator = AppCoordinator(window: window!)
//        self.appCoordinator.start()
        
        let viewModel = HomeViewModel()
        let navigationController = UINavigationController(rootViewController: HomeViewController(viewModel: viewModel))
        window?.rootViewController = navigationController
        
        askLocation()
        
        return true
    }
    
    func askLocation() {
        LocationManager.shared.getUserLocation { location in
            
        }
    }
}

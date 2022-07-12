//
//  AppCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/7/22.
//

import Foundation
import UIKit

//class AppCoordinator: RootViewCoordinator {
//    var childCoordinators: [Coordinator] = []
//    
//    private(set) var rootViewController: UIViewController = UIViewController() {
//        didSet {
//            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
//                self.window.rootViewController = self.rootViewController
//            })
//        }
//    }
//    
//    let window: UIWindow
//    
//    // MARK: - Init
//    public init(window: UIWindow) {
//        self.window = window
//        self.window.backgroundColor = .white
//        self.window.rootViewController = rootViewController
//        self.window.makeKeyAndVisible()
//    }
//    
//    private func setCurrentCoordinator(_ coordinator: RootViewCoordinator) {
//        rootViewController = coordinator.rootViewController
//    }
//    
//    /// Starts the coordinator
//    func start() {
//        let schoolListCoordinator = SchoolListCoordinator()
//        addChildCoordinator(schoolListCoordinator)
//        setCurrentCoordinator(schoolListCoordinator)
//        
//    }
//}

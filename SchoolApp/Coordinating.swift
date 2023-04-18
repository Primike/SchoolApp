//
//  Coordinating.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

protocol Coordinating: AnyObject {
    var parentCoordinator: Coordinating? { get set }
    var navigationController: UINavigationController? { get set }
    var childCoordinators: [Coordinating] { get set }
    func start()
    func childDidFinish(_ child: Coordinating)
    func didFinish()
}

extension Coordinating {
    var parentCoordinator: Coordinating? {
        get { return nil }
        set {}
    }
    
    func childDidFinish(_ child: Coordinating) {
        // Default implementation
    }
    
    func didFinish() {
        
    }
}

//protocol ChildCoordinating: Coordinating {
//    var parentCoordinator: Coordinating? { get set }
//}
//
//extension ChildCoordinating {
//    func didFinish() {
//
//    }
//}

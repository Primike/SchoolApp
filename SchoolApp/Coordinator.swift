//
//  Coordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

protocol Coordinating: AnyObject {
    var navigationController: UINavigationController? { get set }
    var childCoordinators: [ChildCoordinating] { get set }
    func start()
    func childDidFinish(_ child: Coordinating)
}

extension Coordinating {
    func childDidFinish(_ child: Coordinating) {
        // Default implementation
    }
}

protocol ChildCoordinating: Coordinating {
    var parentCoordinator: Coordinating? { get set }
}

extension ChildCoordinating {
    func didFinish() {
        
    }
}

//
//  SATSearchCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/16/23.
//

import Foundation
import UIKit

class SATSearchCoordinator: Coordinating {
    var navigationController: UINavigationController?
    
    var childCoordinators: [Coordinating]
    
    public required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    
}

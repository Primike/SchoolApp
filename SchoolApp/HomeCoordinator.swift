//
//  HomeCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

import Foundation
import UIKit

protocol Coordinating {
    var navigationController: UINavigationController? { get set }
    func start()
}

class HomeCoordinator: Coordinating {
    weak var navigationController: UINavigationController?
    var childCoordinators: [Coordinating] = []
    
    public required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let dataManager = HomeDataManager()
        let viewModel = HomeViewModel(dataManager: dataManager)
        
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

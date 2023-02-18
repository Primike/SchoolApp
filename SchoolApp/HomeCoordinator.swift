//
//  HomeCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

import Foundation
import UIKit

protocol HomeCoordinating {
    var navigationController: UINavigationController? { get set }
    func start()
}

class HomeCoordinator: HomeCoordinating {
    weak var navigationController: UINavigationController?
    
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

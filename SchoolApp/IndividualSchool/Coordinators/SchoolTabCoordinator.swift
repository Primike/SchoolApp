//
//  SchoolTabCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/18/23.
//

import Foundation
import UIKit

class SchoolTabCoordinator: Coordinating {
    
    weak var parentCoordinator: Coordinating?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinating] = []
    var viewControllers: [UIViewController] = []
    let viewModel: SchoolViewModel

    required init(navigationController: UINavigationController, viewModel: SchoolViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        for type in IndividualVCType.allCases {
            let navController = UINavigationController()
            let coordinator = IndividualSchoolTabCoordinator(navigationController: navController, viewModel: viewModel, type: type)
            coordinator.parentCoordinator = self
            coordinator.start()
            childCoordinators.append(coordinator)
            viewControllers.append(navController)
        }
        
        let tabBarViewController = SchoolTabBarViewController()
        tabBarViewController.coordinator = self
        tabBarViewController.setViewControllers(viewControllers, animated: true)
        navigationController.present(tabBarViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("School View Deinit")
    }
}

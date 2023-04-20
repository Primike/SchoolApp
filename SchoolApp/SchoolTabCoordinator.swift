//
//  SchoolTabCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/18/23.
//

import Foundation
import UIKit

class SchoolTabCoordinator: Coordinating {
    var parentCoordinator: Coordinating?
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinating] = []
    var viewModel: SchoolViewModel

    required init(navigationController: UINavigationController?, viewModel: SchoolViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let searchTotalNavController = UINavigationController()
        let searchTotalCoordinator = SchoolInfoCoordinator(navigationController: searchTotalNavController, viewModel: viewModel)
        searchTotalCoordinator.parentCoordinator = self
        searchTotalCoordinator.start()
        childCoordinators.append(searchTotalCoordinator)

        let searchMathNavController = UINavigationController()
        let searchMathCoordinator = SchoolScoresCoordinator(navigationController: searchMathNavController, viewModel: viewModel)
        searchMathCoordinator.parentCoordinator = self
        searchMathCoordinator.start()
        childCoordinators.append(searchMathCoordinator)
        
        let searchReadingNavController = UINavigationController()
        let searchReadingCoordinator = SchoolMapCoordinator(navigationController: searchReadingNavController, viewModel: viewModel)
        searchReadingCoordinator.parentCoordinator = self
        searchReadingCoordinator.start()
        childCoordinators.append(searchReadingCoordinator)

        let tabBarViewController = SchoolTabBarViewController()
        tabBarViewController.coordinator = self
        tabBarViewController.setViewControllers([searchTotalNavController, searchMathNavController, searchReadingNavController], animated: true)
        navigationController.present(tabBarViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("SAT Search Tab Coordinator")
    }
}

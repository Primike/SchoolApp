//
//  SATSearchTabBarCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/16/23.
//

import Foundation
import UIKit

class SATSearchTabBarCoordinator: Coordinating {
    var parentCoordinator: Coordinating?
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinating] = []
    var viewModel: SearchSATScoresViewModel

    required init(navigationController: UINavigationController?, viewModel: SearchSATScoresViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let searchTotalNavController = UINavigationController()
        let searchTotalCoordinator = SATSearchCoordinator(navigationController: searchTotalNavController, viewModel: viewModel, searchType: .totalSearch)
        searchTotalCoordinator.parentCoordinator = self
        searchTotalCoordinator.start()
        childCoordinators.append(searchTotalCoordinator)

        let searchMathNavController = UINavigationController()
        let searchMathCoordinator = SATSearchCoordinator(navigationController: searchMathNavController, viewModel: viewModel, searchType: .mathSearch)
        searchMathCoordinator.parentCoordinator = self
        searchMathCoordinator.start()
        childCoordinators.append(searchMathCoordinator)
        
        let searchReadingNavController = UINavigationController()
        let searchReadingCoordinator = SATSearchCoordinator(navigationController: searchReadingNavController, viewModel: viewModel, searchType: .readingSearch)
        searchReadingCoordinator.parentCoordinator = self
        searchReadingCoordinator.start()
        childCoordinators.append(searchReadingCoordinator)

        let searchWritingNavController = UINavigationController()
        let searchWritingCoordinator = SATSearchCoordinator(navigationController: searchWritingNavController, viewModel: viewModel, searchType: .writingSearch)
        searchWritingCoordinator.parentCoordinator = self
        searchWritingCoordinator.start()
        childCoordinators.append(searchWritingCoordinator)


        let tabBarViewController = SchoolTabBarViewController()
        tabBarViewController.coordinator = self
        tabBarViewController.setViewControllers([searchTotalNavController, searchMathNavController, searchReadingNavController, searchWritingNavController], animated: true)
        navigationController.pushViewController(tabBarViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("SAT Search Tab Coordinator")
    }
}

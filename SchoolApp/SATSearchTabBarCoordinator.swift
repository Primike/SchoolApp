//
//  SATSearchTabBarCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/16/23.
//

import Foundation
import UIKit

class SATSearchTabBarCoordinator: ChildCoordinating {
    var parentCoordinator: Coordinating?
    var navigationController: UINavigationController?
    var childCoordinators: [ChildCoordinating] = []
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
        let searchTotalCoordinator = SearchTotalScoreCoordinator(navigationController: searchTotalNavController, viewModel: viewModel)
        searchTotalCoordinator.parentCoordinator = self
        searchTotalCoordinator.start()
        childCoordinators.append(searchTotalCoordinator)

        let searchMathNavController = UINavigationController()
        let searchMathCoordinator = SearchMathScoreCoordinator(navigationController: searchMathNavController, viewModel: viewModel)
        searchMathCoordinator.parentCoordinator = self
        searchMathCoordinator.start()
        childCoordinators.append(searchMathCoordinator)
        
        let searchReadingNavController = UINavigationController()
        let searchReadingCoordinator = SearchReadingScoreCoordinator(navigationController: searchReadingNavController, viewModel: viewModel)
        searchReadingCoordinator.parentCoordinator = self
        searchReadingCoordinator.start()
        childCoordinators.append(searchReadingCoordinator)

        let searchWritingNavController = UINavigationController()
        let searchWritingCoordinator = SearchWritingScoreCoordinator(navigationController: searchWritingNavController, viewModel: viewModel)
        searchWritingCoordinator.parentCoordinator = self
        searchWritingCoordinator.start()
        childCoordinators.append(searchWritingCoordinator)


        let tabBarViewController = SearchSATScoresTabBarViewController()
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

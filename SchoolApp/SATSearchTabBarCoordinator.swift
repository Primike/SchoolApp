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
    var schools: [School]
    var satData: [SATData]

    required init(navigationController: UINavigationController?, schools: [School], satData: [SATData]) {
        self.navigationController = navigationController
        self.schools = schools
        self.satData = satData
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let searchTotalNavController = UINavigationController()
        let searchTotalCoordinator = SATSearchCoordinator(navigationController: searchTotalNavController, viewModel: SearchSATScoresViewModel(schools: schools, schoolsScores: satData), searchType: .totalSearch)
        searchTotalCoordinator.parentCoordinator = self
        searchTotalCoordinator.start()
        childCoordinators.append(searchTotalCoordinator)

        let searchMathNavController = UINavigationController()
        let searchMathCoordinator = SATSearchCoordinator(navigationController: searchMathNavController, viewModel: SearchSATScoresViewModel(schools: schools, schoolsScores: satData), searchType: .mathSearch)
        searchMathCoordinator.parentCoordinator = self
        searchMathCoordinator.start()
        childCoordinators.append(searchMathCoordinator)
        
        let searchReadingNavController = UINavigationController()
        let searchReadingCoordinator = SATSearchCoordinator(navigationController: searchReadingNavController, viewModel: SearchSATScoresViewModel(schools: schools, schoolsScores: satData), searchType: .readingSearch)
        searchReadingCoordinator.parentCoordinator = self
        searchReadingCoordinator.start()
        childCoordinators.append(searchReadingCoordinator)

        let searchWritingNavController = UINavigationController()
        let searchWritingCoordinator = SATSearchCoordinator(navigationController: searchWritingNavController, viewModel: SearchSATScoresViewModel(schools: schools, schoolsScores: satData), searchType: .writingSearch)
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

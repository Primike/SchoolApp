//
//  TopSchoolsCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/16/23.
//

import Foundation
import UIKit

class TopSchoolsTabBarCoordinator: ChildCoordinating {
    var parentCoordinator: Coordinating?
    var navigationController: UINavigationController?
    var childCoordinators: [ChildCoordinating] = []
    var viewModel: TopSchoolsViewModel

    required init(navigationController: UINavigationController?, viewModel: TopSchoolsViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let topSchoolsNavController = UINavigationController()
        let topSchoolsCoordinator = TopSchoolsCoordinator(navigationController: topSchoolsNavController, viewModel: viewModel)
        topSchoolsCoordinator.parentCoordinator = self
        topSchoolsCoordinator.start()
        childCoordinators.append(topSchoolsCoordinator)

        let topMathNavController = UINavigationController()
        let topMathCoordinator = TopMathSchoolsCoordinator(navigationController: topMathNavController, viewModel: viewModel)
        topMathCoordinator.parentCoordinator = self
        topMathCoordinator.start()
        childCoordinators.append(topMathCoordinator)
        
        let topReadingNavController = UINavigationController()
        let topReadingCoordinator = TopReadingSchoolsCoordinator(navigationController: topReadingNavController, viewModel: viewModel)
        topReadingCoordinator.parentCoordinator = self
        topReadingCoordinator.start()
        childCoordinators.append(topReadingCoordinator)

        let topWritingNavController = UINavigationController()
        let topWritingCoordinator = TopWritingSchoolsCoordinator(navigationController: topWritingNavController, viewModel: viewModel)
        topWritingCoordinator.parentCoordinator = self
        topWritingCoordinator.start()
        childCoordinators.append(topWritingCoordinator)


        let tabBarViewController = TopSchoolsTabBarViewController()
        tabBarViewController.coordinator = self
        tabBarViewController.setViewControllers([topSchoolsNavController, topMathNavController, topReadingNavController, topWritingNavController], animated: true)
        navigationController.pushViewController(tabBarViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("Top Schools Tab Coordinator")
    }
}

//
//  MySchoolsTabBarCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/16/23.
//

import Foundation
import UIKit

class MySchoolsTabBarCoordinator: Coordinating {
    weak var parentCoordinator: Coordinating?
    weak var navigationController: UINavigationController?
    var childCoordinators: [Coordinating] = []
    var viewModel: MySchoolsViewModel
    
    required init(navigationController: UINavigationController?, viewModel: MySchoolsViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }

        let mySchoolsNavController = UINavigationController()
        let mySchoolsCoordinator = MySchoolsCoordinator(navigationController: mySchoolsNavController, viewModel: viewModel)
        mySchoolsCoordinator.parentCoordinator = self
        mySchoolsCoordinator.start()
        childCoordinators.append(mySchoolsCoordinator)

        let schoolComparisonNavController = UINavigationController()
        let schoolComparisonCoordinator = SchoolComparisonCoordinator(navigationController: schoolComparisonNavController, viewModel: viewModel)
        schoolComparisonCoordinator.parentCoordinator = self
        schoolComparisonCoordinator.start()
        childCoordinators.append(schoolComparisonCoordinator)

        let tabBarViewController = SchoolTabBarViewController()
        tabBarViewController.coordinator = self
        tabBarViewController.setViewControllers([mySchoolsNavController, schoolComparisonNavController], animated: true)
        navigationController.pushViewController(tabBarViewController, animated: true)
    }

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("schoollistcoordinaot")
    }
}

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
    var navigationController: UINavigationController
    var childCoordinators: [Coordinating] = []
    var schoolsData: [SchoolData]
    
    required init(navigationController: UINavigationController, schoolsData: [SchoolData]) {
        self.navigationController = navigationController
        self.schoolsData = schoolsData
    }

    func start() {
        let mySchoolsNavController = UINavigationController()
        let mySchoolsCoordinator = MySchoolsCoordinator(navigationController: mySchoolsNavController, viewModel: MySchoolsViewModel(schoolsData: schoolsData))
        mySchoolsCoordinator.parentCoordinator = self
        mySchoolsCoordinator.start()
        childCoordinators.append(mySchoolsCoordinator)

        let schoolComparisonNavController = UINavigationController()
        let schoolComparisonCoordinator = SchoolComparisonCoordinator(navigationController: schoolComparisonNavController, viewModel: MySchoolsViewModel(schoolsData: schoolsData))
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

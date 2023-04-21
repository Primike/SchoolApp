//
//  TopSchoolsCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/16/23.
//

import Foundation
import UIKit

class TopSchoolsTabBarCoordinator: Coordinating {
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
        
        let topSchoolsNavController = UINavigationController()
        let topSchoolsCoordinator = TopSchoolsCoordinator(navigationController: topSchoolsNavController, viewModel: TopSchoolsViewModel(schools: schools, schoolsScores: satData), searchType: .topSchools)
        topSchoolsCoordinator.parentCoordinator = self
        topSchoolsCoordinator.start()
        childCoordinators.append(topSchoolsCoordinator)

        let topMathNavController = UINavigationController()
        let topMathCoordinator = TopSchoolsCoordinator(navigationController: topMathNavController, viewModel: TopSchoolsViewModel(schools: schools, schoolsScores: satData), searchType: .topMath)
        topMathCoordinator.parentCoordinator = self
        topMathCoordinator.start()
        childCoordinators.append(topMathCoordinator)
        
        let topReadingNavController = UINavigationController()
        let topReadingCoordinator = TopSchoolsCoordinator(navigationController: topReadingNavController, viewModel: TopSchoolsViewModel(schools: schools, schoolsScores: satData), searchType: .topReading)
        topReadingCoordinator.parentCoordinator = self
        topReadingCoordinator.start()
        childCoordinators.append(topReadingCoordinator)

        let topWritingNavController = UINavigationController()
        let topWritingCoordinator = TopSchoolsCoordinator(navigationController: topWritingNavController, viewModel: TopSchoolsViewModel(schools: schools, schoolsScores: satData), searchType: .topWriting)
        topWritingCoordinator.parentCoordinator = self
        topWritingCoordinator.start()
        childCoordinators.append(topWritingCoordinator)


        let tabBarViewController = SchoolTabBarViewController()
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

//
//  MapSearchCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/16/23.
//

import Foundation
import UIKit

class MapSearchCoordinator: ChildCoordinating {
    var parentCoordinator: Coordinating?
    var navigationController: UINavigationController?
    var childCoordinators: [ChildCoordinating] = []
    var schools: [School]
    var schoolScores: [SATData]

    required init(navigationController: UINavigationController?, schools: [School], schoolScores: [SATData]) {
        self.navigationController = navigationController
        self.schools = schools
        self.schoolScores = schoolScores
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let viewModel = MapSearchViewModel(schools: schools, schoolsScores: schoolScores)
        
        let viewController = MapSearchTabBarViewController(schools: schools, schoolsScores: schoolScores)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("schoollistcoordinaot")
    }
}

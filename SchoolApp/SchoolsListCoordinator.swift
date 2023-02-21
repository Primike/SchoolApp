//
//  SchoolsListCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/20/23.
//

import Foundation
import UIKit

class SchoolsListCoordinator: Coordinating {
    weak var parentCoordinator: HomeCoordinator?
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinating] = []
    var schools: [School]
    var schoolScores: [SATScores]
    
    required init(navigationController: UINavigationController?, schools: [School], schoolScores: [SATScores]) {
        self.navigationController = navigationController
        self.schools = schools
        self.schoolScores = schoolScores
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let viewModel = SchoolsListViewModel(schools: schools, schoolsScores: schoolScores)
        
        let viewController = SchoolsListViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    deinit {
        print("QWEWQE")
    }
}

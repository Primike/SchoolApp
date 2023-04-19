//
//  SchoolsListCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/20/23.
//

import Foundation
import UIKit

class SchoolsListCoordinator: Coordinating {
    weak var parentCoordinator: Coordinating?
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinating] = []
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
        
        let viewModel = SchoolsListViewModel(schools: schools, schoolsScores: schoolScores)
        
        let viewController = SchoolsListViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func goToSchoolView(school: School, schoolScores: SATData) {
        guard let navigationController = navigationController else {
            return
        }
        
        let viewModel = SchoolViewModel(school: school, scores: schoolScores)
        let coordinator = SchoolTabCoordinator(navigationController: navigationController, viewModel: viewModel)
        
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
        
    func childDidFinish(_ child: Coordinating) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
    
    deinit {
        print("School List Coordinator")
    }
}

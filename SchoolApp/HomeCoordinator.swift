//
//  HomeCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

import Foundation
import UIKit

protocol Coordinating: AnyObject {
    var navigationController: UINavigationController? { get set }
    var childCoordinators: [Coordinating] { get set }
    func start()
}

class HomeCoordinator: Coordinating {
    weak var navigationController: UINavigationController?
    var childCoordinators: [Coordinating] = []
    
    public required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let dataManager = HomeDataManager()
        let viewModel = HomeViewModel(dataManager: dataManager)
        
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToSchoolsList(schools: [School], schoolScores: [SATData]) {
        guard let navigationController = navigationController else {
            return
        }

        let schoolsListCoordinator = SchoolsListCoordinator(navigationController: navigationController, schools: schools, schoolScores: schoolScores)
        
        childCoordinators.append(schoolsListCoordinator)
        schoolsListCoordinator.parentCoordinator = self
        schoolsListCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinating) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
}

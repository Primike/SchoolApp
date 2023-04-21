//
//  HomeCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

import Foundation
import UIKit

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
    
    func goToViewController(type: ViewControllerType, schools: [School], schoolScores: [SATData]) {
        guard let navigationController = navigationController else {
            return
        }
                
        let coordinator: Coordinating
        
        switch type {
        case .schoolsList:
            coordinator = SchoolsListCoordinator(navigationController: navigationController, schools: schools, schoolScores: schoolScores)
            
        case .mapSearch:
            coordinator = MapSearchTabBarCoordinator(navigationController: navigationController, schools: schools, satData: schoolScores)

        case .mySchools:
            let viewModel = MySchoolsViewModel(schools: schools, schoolsScores: schoolScores)
            coordinator = MySchoolsTabBarCoordinator(navigationController: navigationController, schools: schools, satData: schoolScores)
            
        case .topSchools:
            let viewModel = TopSchoolsViewModel(schools: schools, schoolsScores: schoolScores)
            coordinator = TopSchoolsCoordinator(navigationController: navigationController, schools: schools, schoolScores: schoolScores)

        case .satSearch:
            let viewModel = SearchSATScoresViewModel(schools: schools, schoolsScores: schoolScores)
            coordinator = SATSearchTabBarCoordinator(navigationController: navigationController, schools: schools, satData: schoolScores)

        }
        
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func childDidFinish(_ child: Coordinating) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
}

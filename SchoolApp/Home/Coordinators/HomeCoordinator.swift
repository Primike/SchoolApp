//
//  HomeCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinating {
    
    var childCoordinators: [Coordinating] = []
    var navigationController: UINavigationController

    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let dataManager = HomeDataManager()
        let viewModel = HomeViewModel(dataManager: dataManager)
        
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToViewController(type: ViewControllerType, schools: [School], satData: [SATData]) {
        let coordinator: Coordinating
        
        switch type {
        case .schoolsList:
            coordinator = SchoolsListCoordinator(navigationController: navigationController, schools: schools, satData: satData)
            
        case .mapSearch:
            coordinator = MapSearchCoordinator(navigationController: navigationController, schools: schools, satData: satData)

        case .mySchools:
            coordinator = MySchoolsTabBarCoordinator(navigationController: navigationController, schools: schools, satData: satData)
            
        case .about:
            coordinator = MySchoolsTabBarCoordinator(navigationController: navigationController, schools: schools, satData: satData)
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
    
    deinit {
        print("Home Coordinator Deinit")
    }
}

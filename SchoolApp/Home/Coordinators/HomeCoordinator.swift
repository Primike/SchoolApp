//
//  HomeCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinating {
    
    private let navigationController: UINavigationController
    private var childCoordinators: [Coordinating] = []

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
    
    func goToViewController(type: ViewControllerType, schoolsData: [SchoolData]) {
        let coordinator: Coordinating
        
        switch type {
        case .schoolsList:
            coordinator = SchoolsListCoordinator(navigationController: navigationController, schoolsData: schoolsData)
        case .mapSearch:
            coordinator = MapSearchCoordinator(navigationController: navigationController, schoolsData: schoolsData)
        case .mySchools:
            coordinator = MySchoolsCoordinator(navigationController: navigationController, schoolsData: schoolsData)
        case .about:
            coordinator = MySchoolsCoordinator(navigationController: navigationController, schoolsData: schoolsData)
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

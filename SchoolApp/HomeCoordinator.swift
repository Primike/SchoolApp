//
//  HomeCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//
enum ViewControllerType {
    case schoolsList
    case mapSearch
    case mySchools
    case topSchools
    case satSearch
}

extension Coordinating {
    func childDidFinish(_ child: Coordinating) {
        // Default implementation
    }
}

import Foundation
import UIKit

protocol Coordinating: AnyObject {
    var navigationController: UINavigationController? { get set }
    var childCoordinators: [ChildCoordinating] { get set }
    func start()
    func childDidFinish(_ child: Coordinating)
}

protocol ChildCoordinating: Coordinating {
    var parentCoordinator: Coordinating? { get set }
}

class HomeCoordinator: Coordinating {
    weak var navigationController: UINavigationController?
    var childCoordinators: [ChildCoordinating] = []
    
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
                
        let coordinator: ChildCoordinating
        
        switch type {
        case .schoolsList:
            coordinator = SchoolsListCoordinator(navigationController: navigationController, schools: schools, schoolScores: schoolScores)
        case .mapSearch:
            var viewModel = MySchoolsViewModel(schools: schools, schoolsScores: schoolScores)
            coordinator = MySchoolsTabBarCoordinator(navigationController: navigationController, viewModel: viewModel)

        case .mySchools:
            var viewModel = MySchoolsViewModel(schools: schools, schoolsScores: schoolScores)
            coordinator = MySchoolsCoordinator(navigationController: navigationController, viewModel: viewModel)
        case .topSchools:
            var viewModel = MySchoolsViewModel(schools: schools, schoolsScores: schoolScores)
            coordinator = MySchoolsCoordinator(navigationController: navigationController, viewModel: viewModel)

        case .satSearch:
            var viewModel = MySchoolsViewModel(schools: schools, schoolsScores: schoolScores)
            coordinator = MySchoolsCoordinator(navigationController: navigationController, viewModel: viewModel)

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

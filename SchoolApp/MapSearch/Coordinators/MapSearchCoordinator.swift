//
//  MapSearchCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/18/23.
//

import Foundation
import UIKit

class MapSearchCoordinator: Coordinating {
    weak var parentCoordinator: Coordinating?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinating] = []
    var schools: [School]
    var satData: [SATData]
    
    enum SearchType {
        case radius, address
    }
    
    required init(navigationController: UINavigationController, schools: [School], satData: [SATData]) {
        self.navigationController = navigationController
        self.schools = schools
        self.satData = satData
    }
    
    func start() {
        let viewController = MapSearchViewController(viewModel: MapSearchViewModel(schools: schools, schoolsScores: satData))
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToSchoolView(school: School, schoolScores: SATData) {
        let viewModel = SchoolViewModel(school: school, satData: schoolScores)
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
        print("Map Search Coordinator")
    }
}


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
    var schoolsData: [SchoolData]
    
    required init(navigationController: UINavigationController, schoolsData: [SchoolData]) {
        self.navigationController = navigationController
        self.schoolsData = schoolsData
    }

    func start() {
        let viewController = MapSearchViewController(viewModel: MapSearchViewModel(schoolsData: schoolsData))
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToSchoolView(schoolData: SchoolData) {
        let viewModel = SchoolViewModel(schoolData: schoolData)
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


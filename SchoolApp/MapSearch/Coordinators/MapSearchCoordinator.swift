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
    private let navigationController: UINavigationController
    private var childCoordinators: [Coordinating] = []
    private let viewModel: MapSearchViewModel
    private let filterVC: MapFilterViewController
    
    required init(navigationController: UINavigationController, schoolsData: [SchoolData]) {
        self.navigationController = navigationController
        self.viewModel = MapSearchViewModel(schoolsData: schoolsData)
        self.filterVC = MapFilterViewController(viewModel: viewModel)
    }

    func start() {
        let viewController = MapSearchViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: - Goes To Filter View
    func goToFilterView(viewController: MapSearchViewController) {
//        let mapFilter = MapFilterViewController(viewModel: viewModel)
        filterVC.coordinator = self
        filterVC.delegate = viewController
        navigationController.pushViewController(filterVC, animated: true)
    }
    
    // MARK: - Goes To School View
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

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }

    deinit {
        print("Map Search Coordinator")
    }
}

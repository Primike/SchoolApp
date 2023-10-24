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
    private let navigationController: UINavigationController
    private var childCoordinators: [Coordinating] = []
    private let schoolsData: [SchoolData]
    
    required init(navigationController: UINavigationController, schoolsData: [SchoolData]) {
        self.navigationController = navigationController
        self.schoolsData = schoolsData
    }
    
    func start() {
        let viewModel = SchoolsListViewModel(schoolsData: schoolsData)
        let viewController = SchoolsListViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Navigates To Individual School View
    func goToSchoolView(schoolData: SchoolData) {
        let viewModel = SchoolViewModel(schoolData: schoolData)
        let coordinator = SchoolTabCoordinator(navigationController: navigationController, viewModel: viewModel)
        
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
        
    // MARK: - Called By Child Coordinator
    func childDidFinish(_ child: Coordinating) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
    
    // MARK: - Calls Method On Parent Coordinator
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("School List Coordinator Deinit")
    }
}

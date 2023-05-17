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
    var navigationController: UINavigationController
    var childCoordinators: [Coordinating] = []
    var schools: [School]
    var satData: [SATData]
    
    required init(navigationController: UINavigationController, schools: [School], satData: [SATData]) {
        self.navigationController = navigationController
        self.schools = schools
        self.satData = satData
    }
    
    func start() {
        let viewModel = SchoolsListViewModel(schools: schools, satData: satData)
        
        let viewController = SchoolsListViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //MARK: Navigates To Individual School View
    func goToSchoolView(school: School, satData: SATData) {
        let viewModel = SchoolViewModel(school: school, satData: satData)
        let coordinator = SchoolTabCoordinator(navigationController: navigationController, viewModel: viewModel)
        
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
        
    //MARK: Called By Child Coordinator
    func childDidFinish(_ child: Coordinating) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
    
    //MARK: Calls Method On Parent Coordinator
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("School List Coordinator Deinit")
    }
}

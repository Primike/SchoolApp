//
//  MySchoolsCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/16/23.
//

import Foundation
import UIKit

class MySchoolsCoordinator: Coordinating {
    
    weak var parentCoordinator: Coordinating?
    private let navigationController: UINavigationController
    private var childCoordinators: [Coordinating] = []
    private let schoolsData: [SchoolData]
    
    required init(navigationController: UINavigationController, schoolsData: [SchoolData]) {
        self.navigationController = navigationController
        self.schoolsData = schoolsData
    }
    
    func start() {
        let viewModel = MySchoolsViewModel(schoolsData: schoolsData)
        let viewController = MySchoolsViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Goes To Comparison VC
    func goToComparison(school1: SchoolData, school2: SchoolData) {
        let viewContoller = ComparisonViewController(school1: school1, school2: school2)
        navigationController.present(viewContoller, animated: true)
    }
    
    // MARK: - Goes To The Individual School VC
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
        print("myschoolscoordinator")
    }
}

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
    var navigationController: UINavigationController
    var childCoordinators: [Coordinating] = []
    var viewModel: MySchoolsViewModel
    
    required init(navigationController: UINavigationController, viewModel: MySchoolsViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let mySchoolsViewController = MySchoolsViewController(viewModel: viewModel)
        mySchoolsViewController.coordinator = self
        navigationController.tabBarItem.title = "My Schools"
        navigationController.tabBarItem.image = UIImage(systemName: "heart.circle.fill")

        navigationController.pushViewController(mySchoolsViewController, animated: false)

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
        print("myschoolscoordinator")
    }
}

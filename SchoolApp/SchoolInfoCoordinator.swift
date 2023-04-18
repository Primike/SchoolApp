//
//  SchoolInfoCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/18/23.
//

import Foundation
import UIKit

class SchoolInfoCoordinator: ChildCoordinating {
    weak var parentCoordinator: Coordinating?
    weak var navigationController: UINavigationController?
    var childCoordinators: [ChildCoordinating] = []
    var viewModel: SchoolViewModel
    
    required init(navigationController: UINavigationController?, viewModel: SchoolViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let schoolsInfoViewController = SchoolInfoViewController(viewModel: viewModel)
        schoolsInfoViewController.coordinator = self
        navigationController.tabBarItem.title = "Summary"
        navigationController.tabBarItem.image = UIImage(systemName: "graduationcap")

        navigationController.pushViewController(schoolsInfoViewController, animated: false)

    }

    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("SAT Score Coordinator")
    }
}

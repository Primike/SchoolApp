//
//  TopSchoolsCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

class TopSchoolsCoordinator: ChildCoordinating {
    weak var parentCoordinator: Coordinating?
    weak var navigationController: UINavigationController?
    var childCoordinators: [ChildCoordinating] = []
    var viewModel: TopSchoolsViewModel
    
    required init(navigationController: UINavigationController?, viewModel: TopSchoolsViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let topSchoolsViewController = TopSchoolsViewController(viewModel: viewModel)
        topSchoolsViewController.coordinator = self
        navigationController.tabBarItem.title = "Top Schools"
        navigationController.tabBarItem.image = UIImage(systemName: "star.fill")

        navigationController.pushViewController(topSchoolsViewController, animated: false)

    }

    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("Top Schools Coordinator")
    }
}

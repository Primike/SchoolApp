//
//  TopWritingSchoolsCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

class TopWritingSchoolsCoordinator: ChildCoordinating {
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
        
        let topWritingViewController = TopWritingSchoolsViewController(viewModel: viewModel)
        topWritingViewController.coordinator = self
        navigationController.tabBarItem.title = "Top Writing"
        navigationController.tabBarItem.image = UIImage(systemName: "pencil")

        navigationController.pushViewController(topWritingViewController, animated: false)

    }

    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("Top Reading Coordinator")
    }
}





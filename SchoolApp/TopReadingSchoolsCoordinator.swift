//
//  TopReadingSchoolsCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

class TopReadingSchoolsCoordinator: Coordinating {
    weak var parentCoordinator: Coordinating?
    weak var navigationController: UINavigationController?
    var childCoordinators: [Coordinating] = []
    var viewModel: TopSchoolsViewModel
    
    required init(navigationController: UINavigationController?, viewModel: TopSchoolsViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let topReadingViewController = TopReadingSchoolsViewController(viewModel: viewModel)
        topReadingViewController.coordinator = self
        navigationController.tabBarItem.title = "Top Reading"
        navigationController.tabBarItem.image = UIImage(systemName: "book.fill")

        navigationController.pushViewController(topReadingViewController, animated: false)

    }

    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("Top Reading Coordinator")
    }
}




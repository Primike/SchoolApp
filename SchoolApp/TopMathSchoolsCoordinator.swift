//
//  TopMathSchoolsCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

class TopMathSchoolsCoordinator: Coordinating {
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
        
        let topMathViewController = TopMathSchoolsViewController(viewModel: viewModel)
        topMathViewController.coordinator = self
        navigationController.tabBarItem.title = "Top Math"
        navigationController.tabBarItem.image = UIImage(systemName: "x.squareroot")

        navigationController.pushViewController(topMathViewController, animated: false)

    }

    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("Top Math Coordinator")
    }
}



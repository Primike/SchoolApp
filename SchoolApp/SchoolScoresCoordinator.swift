//
//  SchoolScoresCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/18/23.
//

import Foundation
import UIKit

class SchoolScoresCoordinator: ChildCoordinating {
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
        
        let schoolScoresViewController = SchoolScoresViewController(viewModel: viewModel)
        schoolScoresViewController.coordinator = self
        navigationController.tabBarItem.title = "SAT Scores"
        navigationController.tabBarItem.image = UIImage(systemName: "percent")

        navigationController.pushViewController(schoolScoresViewController, animated: false)

    }

    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("School Score Coordinator")
    }
}
//
//  SearchMathScoreCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

class SearchMathScoreCoordinator: ChildCoordinating {
    weak var parentCoordinator: Coordinating?
    weak var navigationController: UINavigationController?
    var childCoordinators: [ChildCoordinating] = []
    var viewModel: SearchSATScoresViewModel
    
    required init(navigationController: UINavigationController?, viewModel: SearchSATScoresViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let topSchoolsViewController = SearchMathScoreViewController(viewModel: viewModel)
        topSchoolsViewController.coordinator = self
        navigationController.tabBarItem.title = "Math Score"
        navigationController.tabBarItem.image = UIImage(systemName: "x.squareroot")

        navigationController.pushViewController(topSchoolsViewController, animated: false)

    }

    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("Math Score Coordinator")
    }
}

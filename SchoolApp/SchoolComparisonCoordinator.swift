//
//  SchoolComparisonCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/16/23.
//

import Foundation
import UIKit

class SchoolComparisonCoordinator: ChildCoordinating {
    weak var parentCoordinator: Coordinating?
    weak var navigationController: UINavigationController?
    var childCoordinators: [ChildCoordinating] = []
    var viewModel: MySchoolsViewModel
    
    required init(navigationController: UINavigationController?, viewModel: MySchoolsViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let schoolComparisonViewController = SchoolComparisonViewController(viewModel: viewModel)
        schoolComparisonViewController.coordinator = self
        navigationController.tabBarItem.title = "Compare Schools"
        navigationController.tabBarItem.image = UIImage(systemName: "arrow.up.arrow.down.circle.fill")

        navigationController.pushViewController(schoolComparisonViewController, animated: false)

    }

    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("schoolcomparisoncoordinator")
    }
}


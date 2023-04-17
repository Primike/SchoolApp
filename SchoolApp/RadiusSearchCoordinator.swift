//
//  RadiusSearchCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

class RadiusSearchCoordinator: ChildCoordinating {
    weak var parentCoordinator: Coordinating?
    weak var navigationController: UINavigationController?
    var childCoordinators: [ChildCoordinating] = []
    var viewModel: MapSearchViewModel
    
    required init(navigationController: UINavigationController?, viewModel: MapSearchViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let radiusSearchViewController = RadiusSearchViewController(viewModel: viewModel)
        radiusSearchViewController.coordinator = self
        navigationController.tabBarItem.title = "Radius Search"
        navigationController.tabBarItem.image = UIImage(systemName: "mappin.circle.fill")

        navigationController.pushViewController(radiusSearchViewController, animated: false)

    }

    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("radiuscoor")
    }
}


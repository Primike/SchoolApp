//
//  CoordinateSearchCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

class AddressSearchCoordinator: ChildCoordinating {
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
        
        let addressSearchViewController = AddressSearchViewController(viewModel: viewModel)
        addressSearchViewController.coordinator = self
        navigationController.tabBarItem.title = "Address Search"
        navigationController.tabBarItem.image = UIImage(systemName: "location.magnifyingglass")

        navigationController.pushViewController(addressSearchViewController, animated: false)

    }

    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("addresscoord")
    }
}

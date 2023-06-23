//
//  MapSearchCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/16/23.
//

import Foundation
import UIKit

class MapSearchTabBarCoordinator: Coordinating {
    var parentCoordinator: Coordinating?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinating] = []
    var schools: [School]
    var satData: [SATData]

    required init(navigationController: UINavigationController, schools: [School], satData: [SATData]) {
        self.navigationController = navigationController
        self.schools = schools
        self.satData = satData  
    }
    
    func start() {
        let radiusSearchNavController = UINavigationController()
        let radiusSearchCoordinator = MapSearchCoordinator(navigationController: radiusSearchNavController, viewModel: MapSearchViewModel(schools: schools, schoolsScores: satData), searchType: .radius)
        radiusSearchCoordinator.parentCoordinator = self
        radiusSearchCoordinator.start()
        childCoordinators.append(radiusSearchCoordinator)

        let addressSearchNavController = UINavigationController()
        let addressSearchCoordinator = MapSearchCoordinator(navigationController: addressSearchNavController, viewModel: MapSearchViewModel(schools: schools, schoolsScores: satData), searchType: .address)
        addressSearchCoordinator.parentCoordinator = self
        addressSearchCoordinator.start()
        childCoordinators.append(addressSearchCoordinator)

        let tabBarViewController = SchoolTabBarViewController()
        tabBarViewController.coordinator = self
        tabBarViewController.setViewControllers([radiusSearchNavController, addressSearchNavController], animated: true)
        navigationController.pushViewController(tabBarViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("maptabcoordinaot")
    }
}

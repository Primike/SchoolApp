////
////  TopSchoolsCoordinator.swift
////  SchoolApp
////
////  Created by Prince Avecillas on 4/16/23.
////
//
//import Foundation
//import UIKit
//
//class TopSchoolsCoordinator: ChildCoordinating {
//    var parentCoordinator: Coordinating?
//    var navigationController: UINavigationController?
//    var childCoordinators: [ChildCoordinating] = []
//    var viewModel: TopSchoolsViewModel
//
//    required init(navigationController: UINavigationController?, viewModel: TopSchoolsViewModel) {
//        self.navigationController = navigationController
//        self.viewModel = viewModel
//    }
//    
//    func start() {
//        guard let navigationController = navigationController else {
//            return
//        }
//        
//        let radiusSearchNavController = UINavigationController()
//        let radiusSearchCoordinator = RadiusSearchCoordinator(navigationController: radiusSearchNavController, viewModel: viewModel)
//        radiusSearchCoordinator.parentCoordinator = self
//        radiusSearchCoordinator.start()
//        childCoordinators.append(radiusSearchCoordinator)
//
//        let addressSearchNavController = UINavigationController()
//        let addressSearchCoordinator = AddressSearchCoordinator(navigationController: addressSearchNavController, viewModel: viewModel)
//        addressSearchCoordinator.parentCoordinator = self
//        addressSearchCoordinator.start()
//        childCoordinators.append(addressSearchCoordinator)
//
//        let tabBarViewController = MapSearchTabBarViewController()
//        tabBarViewController.coordinator = self
//        tabBarViewController.setViewControllers([radiusSearchNavController, addressSearchNavController], animated: true)
//        navigationController.pushViewController(tabBarViewController, animated: true)
//    }
//    
//    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
//    }
//    
//    deinit {
//        print("maptabcoordinaot")
//    }
//}

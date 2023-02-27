//
//  HomeCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

import Foundation
import UIKit

protocol Coordinating {
    var navigationController: UINavigationController? { get set }
    var childCoordinators: [Coordinating] { get set }
    func start()
}

class HomeCoordinator: NSObject, UINavigationControllerDelegate, Coordinating {
    var childCoordinators = [Coordinating]()
    weak var navigationController: UINavigationController?
    
    public required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let dataManager = HomeDataManager()
        let viewModel = HomeViewModel(dataManager: dataManager)
        
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToSchoolsList(schools: [School], schoolScores: [SATData]) {
        guard let navigationController = navigationController else {
            return
        }

        let schoolsListCoordinator = SchoolsListCoordinator(navigationController: navigationController, schools: schools, schoolScores: schoolScores)
        
        childCoordinators.append(schoolsListCoordinator)
        schoolsListCoordinator.parentCoordinator = self
        schoolsListCoordinator.start()
    }
    
//    func childDidFinish(_ child: Coordinating?) {
//        for (index, coordinator) in childCoordinators.enumerated() {
//            if coordinator === child {
//                childCoordinators.remove(at: index)
//                break
//            }
//        }
//    }
//    
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//            return
//        }
//        
//        if navigationController.viewControllers.contains(fromViewController) {
//            return
//        }
//        
//        if let schoolsListViewController = fromViewController as? SchoolsListViewController {
//            childDidFinish(schoolsListViewController.coordinator)
//        }
//    }
}

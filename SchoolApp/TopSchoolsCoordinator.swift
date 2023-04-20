//
//  TopSchoolsCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/17/23.
//

import Foundation
import UIKit

class TopSchoolsCoordinator: Coordinating {
    weak var parentCoordinator: Coordinating?
    weak var navigationController: UINavigationController?
    var childCoordinators: [Coordinating] = []
    var viewModel: TopSchoolsViewModel
    var searchType: SearchType
    
    enum SearchType {
        case topSchools, topMath, topReading, topWriting
    }
    
    required init(navigationController: UINavigationController?, viewModel: TopSchoolsViewModel, searchType: SearchType) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.searchType = searchType
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        
        let viewController: UIViewController
        switch searchType {
        case .topSchools:
            let radiusSearchViewController = TopSchoolsViewController(viewModel: viewModel)
            radiusSearchViewController.coordinator = self
            viewController = radiusSearchViewController
            navigationController.tabBarItem.title = "Top Schools"
            navigationController.tabBarItem.image = UIImage(systemName: "star.fill")
        case .topMath:
            let addressSearchViewController = TopMathSchoolsViewController(viewModel: viewModel)
            addressSearchViewController.coordinator = self
            viewController = addressSearchViewController
            navigationController.tabBarItem.title = "Top Math"
            navigationController.tabBarItem.image = UIImage(systemName: "x.squareroot")
        case .topReading:
            let addressSearchViewController = TopReadingSchoolsViewController(viewModel: viewModel)
            addressSearchViewController.coordinator = self
            viewController = addressSearchViewController
            navigationController.tabBarItem.title = "Top Reading"
            navigationController.tabBarItem.image = UIImage(systemName: "book.fill")
        case .topWriting:
            let addressSearchViewController = TopWritingSchoolsViewController(viewModel: viewModel)
            addressSearchViewController.coordinator = self
            viewController = addressSearchViewController
            navigationController.tabBarItem.title = "Top Writing"
            navigationController.tabBarItem.image = UIImage(systemName: "pencil")

        }
        
        navigationController.pushViewController(viewController, animated: false)
    }

    func goToSchoolView(school: School, schoolScores: SATData) {
        guard let navigationController = navigationController else {
            return
        }
        
        let viewModel = SchoolViewModel(school: school, scores: schoolScores)
        let coordinator = SchoolTabCoordinator(navigationController: navigationController, viewModel: viewModel)
        
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
        
    func childDidFinish(_ child: Coordinating) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }

    deinit {
        print("Map Search Coordinator")
    }
}

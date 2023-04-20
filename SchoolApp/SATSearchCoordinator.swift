//
//  SATSearchCoordinator.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/18/23.
//

import Foundation
import UIKit

class SATSearchCoordinator: Coordinating {
    weak var parentCoordinator: Coordinating?
    weak var navigationController: UINavigationController?
    var childCoordinators: [Coordinating] = []
    var viewModel: SearchSATScoresViewModel
    var searchType: SearchType
    
    enum SearchType {
        case totalSearch, mathSearch, readingSearch, writingSearch
    }
    
    required init(navigationController: UINavigationController?, viewModel: SearchSATScoresViewModel, searchType: SearchType) {
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
        case .totalSearch:
            let radiusSearchViewController = SearchTotalScoreViewController(viewModel: viewModel)
            radiusSearchViewController.coordinator = self
            viewController = radiusSearchViewController
            navigationController.tabBarItem.title = "SAT Score"
            navigationController.tabBarItem.image = UIImage(systemName: "star.fill")
        case .mathSearch:
            let addressSearchViewController = SearchMathScoreViewController(viewModel: viewModel)
            addressSearchViewController.coordinator = self
            viewController = addressSearchViewController
            navigationController.tabBarItem.title = "Math Score"
            navigationController.tabBarItem.image = UIImage(systemName: "x.squareroot")
        case .readingSearch:
            let addressSearchViewController = SearchReadingScoreViewController(viewModel: viewModel)
            addressSearchViewController.coordinator = self
            viewController = addressSearchViewController
            navigationController.tabBarItem.title = "Reading Score"
            navigationController.tabBarItem.image = UIImage(systemName: "book.fill")
        case .writingSearch:
            let addressSearchViewController = SearchWritingScoreViewController(viewModel: viewModel)
            addressSearchViewController.coordinator = self
            viewController = addressSearchViewController
            navigationController.tabBarItem.title = "Writing Score"
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

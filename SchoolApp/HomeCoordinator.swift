////
////  AppCoordinator.swift
////  SchoolApp
////
////  Created by Prince Avecillas on 7/7/22.
////
//
//import Foundation
//import UIKit
//
//class HomeCoordinator {
//    weak var presenter: UINavigationController?
//
//    required init(navController: UINavigationController) {
//        self.presenter = navController
//    }
//
//    //MARK: ViewController Initialization
//    func start() {
//        guard let presenter = presenter else {
//            return
//        }
//
//        let dataManager = ActivitySpendDataManager()
//        let viewModel = ActivitySpendViewModel(dataManager: dataManager, accountId: accountId)
//
//        let viewController = HomeViewController()
//        viewController.viewModel = viewModel
//        viewController.coordinator = self
//
//        presenter.pushViewController(viewController, animated: true)
//    }
//}

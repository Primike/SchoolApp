//
//  IndividualSchoolTabCoordinator.swift
//  SchoolApp
//
//  Created by iMac on 10/11/23.
//

import Foundation
import UIKit

class IndividualSchoolTabCoordinator: Coordinating {
    weak var parentCoordinator: Coordinating?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinating] = []
    var viewModel: SchoolViewModel
    var type: IndividualVCType
    
    required init(navigationController: UINavigationController, viewModel: SchoolViewModel, type: IndividualVCType) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.type = type
    }
    
    func start() {
        var viewController = IndividualVCGenerator.generateVC(type: type, viewModel: viewModel) as! Coordinated & UIViewController
        viewController.coordinator = self
        navigationController.tabBarItem.title = IndividualVCGenerator.getTitle(type: type)
        navigationController.tabBarItem.image = UIImage(systemName: IndividualVCGenerator.getImage(type: type))
        navigationController.pushViewController(viewController, animated: false)
    }


    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print(IndividualVCGenerator.getDeinit(type: type))
    }
}

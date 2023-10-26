//
//  SchoolTabBarController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/18/23.
//

import Foundation
import UIKit

class SchoolTabBarViewController: UITabBarController {
    
    var coordinator: Coordinating?
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            dismissViewController()
        }
    }
    
    private func dismissViewController() {
        coordinator?.didFinish()
    }

    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}


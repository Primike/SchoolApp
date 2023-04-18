//
//  TabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/12/22.
//

import Foundation
import UIKit

class SchoolTabBarViewController: UITabBarController {
    weak var coordinator: Coordinating?
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            dismissViewController()
        }
    }
    
    func dismissViewController() {
        coordinator?.didFinish()
    }

    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}




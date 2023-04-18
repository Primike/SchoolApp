//
//  MapTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/24/22.
//

import Foundation
import UIKit

class MapSearchTabBarViewController: UITabBarController {
    var coordinator: Coordinating?
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            dismissViewController()
        }
    }
    
    func dismissViewController() {
        coordinator?.didFinish()
    }

//    private func setupTabBar() {
//        tabBar.tintColor = .black
//        tabBar.isTranslucent = false
//        tabBar.backgroundColor = .white
//    }
}

//
//  TabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/12/22.
//

import Foundation
import UIKit

class SchoolTabBarViewController: UITabBarController {

    weak var coordinator: SchoolTabCoordinator?
        
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

extension UIViewController {
    func setTabBarImage(imageSFName: String, title: String, tag: Int) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageSFName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    }
}



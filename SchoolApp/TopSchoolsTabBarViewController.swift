//
//  TopSchoolsTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class TopSchoolsTabBarViewController: UITabBarController {
    var coordinator: TopSchoolsTabBarCoordinator?
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            dismissViewController()
        }
    }
    
    func dismissViewController() {
        coordinator?.didFinish()
    }
}

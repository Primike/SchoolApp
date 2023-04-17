//
//  MySchoolsTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class MySchoolsTabBarViewController: UITabBarController {
    var coordinator: MySchoolsTabBarCoordinator?
        
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

//
//  MySchoolsTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class MySchoolsTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: UIViewController())
        let vc2 = UINavigationController(rootViewController: UIViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "wrench.and.screwdriver")
        
        vc1.title = "About"
        vc2.title = "Skills"
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        setViewControllers([vc1, vc2], animated: true)
    }
}

//
//  MySchoolsTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class MySchoolsTabBarViewController: UITabBarController {
    
    let mySchoolsViewModel: MySchoolsViewModel
    
    init(viewModel: MySchoolsViewModel) {
        self.mySchoolsViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: MySchoolsViewController(viewModel: mySchoolsViewModel))
        let vc2 = UINavigationController(rootViewController: SchoolComparisonViewController(viewModel: mySchoolsViewModel))
        
        vc1.tabBarItem.image = UIImage(systemName: "heart.circle.fill")
        vc2.tabBarItem.image = UIImage(systemName: "arrow.up.arrow.down.circle.fill")
        
        vc1.title = "My Schools"
        vc2.title = "Compare Schools"
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        setViewControllers([vc1, vc2], animated: true)
    }
}

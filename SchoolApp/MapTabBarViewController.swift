//
//  MapTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/24/22.
//

import Foundation
import UIKit

class MapTabBarViewController: UITabBarController {
    
    let nearbySchoolsViewModel: NearbySchoolsViewModel
    
    init(viewModel: NearbySchoolsViewModel) {
        self.nearbySchoolsViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        
        let topSchoolsVC = RadiusSearchViewController(viewModel: NearbySchoolsViewModel(schoolsSATData: nearbySchoolsViewModel.schoolsScores, schoolsData: nearbySchoolsViewModel.schools))
        let topMathSchoolsVC = TopMathSchoolsViewController(viewModel: TopSchoolsViewModel(schools: nearbySchoolsViewModel.schools, schoolsScores: nearbySchoolsViewModel.schoolsScores))
        let topReadingSchoolsVC = CoordinateSearchViewController(viewModel: NearbySchoolsViewModel(schoolsSATData: nearbySchoolsViewModel.schoolsScores, schoolsData: nearbySchoolsViewModel.schools))

        topSchoolsVC.setTabBarImage(imageSFName: "list.dash.header.rectangle", title: "Radius Search", tag: 0)
        topMathSchoolsVC.setTabBarImage(imageSFName: "arrow.left.arrow.right", title: "Nearby Schools", tag: 1)
        topReadingSchoolsVC.setTabBarImage(imageSFName: "book", title: "Coordinates Search", tag: 2)


        let topSchoolsNC = UINavigationController(rootViewController: topSchoolsVC)
        let topMathSchoolsNC = UINavigationController(rootViewController: topMathSchoolsVC)
        let topReadingSchoolsNC = UINavigationController(rootViewController: topReadingSchoolsVC)
        
        let tabBarList = [topSchoolsNC, topMathSchoolsNC, topReadingSchoolsNC]

        viewControllers = tabBarList
    }

    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}

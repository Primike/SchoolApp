//
//  MapTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/24/22.
//

import Foundation
import UIKit

class MapSearchTabBarViewController: UITabBarController {
    var schools: [School]
    var schoolScores: [SATData]
    var coordinator: ChildCoordinating?
    
    required init(schools: [School], schoolsScores: [SATData]) {
        self.schools = schools
        self.schoolScores = schoolsScores
        
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
        let radiusSearchVC = RadiusSearchViewController(viewModel: MapSearchViewModel(schools: schools, schoolsScores: schoolScores))
        let coordinateSearchVC = AddressSearchViewController(viewModel: MapSearchViewModel(schools: schools, schoolsScores: schoolScores))

        radiusSearchVC.setTabBarImage(imageSFName: "mappin.circle.fill", title: "Radius Search", tag: 0)
        coordinateSearchVC.setTabBarImage(imageSFName: "location.magnifyingglass", title: "Address Search", tag: 2)

        let radiusSearchNC = UINavigationController(rootViewController: radiusSearchVC)
        let coordinateSearchNC = UINavigationController(rootViewController: coordinateSearchVC)
        
        let tabBarList = [radiusSearchNC, coordinateSearchNC]

        viewControllers = tabBarList
    }

    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}

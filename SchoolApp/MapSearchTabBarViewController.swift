//
//  MapTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/24/22.
//

import Foundation
import UIKit

class MapSearchTabBarViewController: UITabBarController {
    
    let nearbySchoolsViewModel: MapSearchViewModel
    
    init(viewModel: MapSearchViewModel) {
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
        
        let radiusSearchVC = RadiusSearchViewController(viewModel: MapSearchViewModel(schoolsSATData: nearbySchoolsViewModel.schoolsScores, schoolsData: nearbySchoolsViewModel.schools))
        let coordinateSearchVC = AddressSearchViewController(viewModel: MapSearchViewModel(schoolsSATData: nearbySchoolsViewModel.schoolsScores, schoolsData: nearbySchoolsViewModel.schools))

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

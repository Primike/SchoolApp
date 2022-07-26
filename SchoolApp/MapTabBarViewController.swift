//
//  MapTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/24/22.
//

import Foundation
import UIKit

class MapTabBarViewController: UITabBarController {
    
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
        let nearbySchoolsVC = NearbySchoolsViewController(viewModel: MapSearchViewModel(schoolsSATData: nearbySchoolsViewModel.schoolsScores, schoolsData: nearbySchoolsViewModel.schools))
        let coordinateSearchVC = CoordinateSearchViewController(viewModel: MapSearchViewModel(schoolsSATData: nearbySchoolsViewModel.schoolsScores, schoolsData: nearbySchoolsViewModel.schools))


        radiusSearchVC.setTabBarImage(imageSFName: "list.dash.header.rectangle", title: "Radius Search", tag: 0)
        nearbySchoolsVC.setTabBarImage(imageSFName: "arrow.left.arrow.right", title: "Nearby Schools", tag: 1)
        coordinateSearchVC.setTabBarImage(imageSFName: "book", title: "Coordinates Search", tag: 2)


        let radiusSearchNC = UINavigationController(rootViewController: radiusSearchVC)
        let nearbySchoolsNC = UINavigationController(rootViewController: nearbySchoolsVC)
        let coordinateSearchNC = UINavigationController(rootViewController: coordinateSearchVC)
        
        let tabBarList = [radiusSearchNC, nearbySchoolsNC, coordinateSearchNC]

        viewControllers = tabBarList
    }

    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}

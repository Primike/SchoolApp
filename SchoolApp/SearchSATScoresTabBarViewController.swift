//
//  SchoolCalculatorTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class SearchSATScoresTabBarViewController: UITabBarController {
    
    let searchSATScoreViewModel: SearchSATScoreViewModel
    
    init(viewModel: SearchSATScoreViewModel) {
        self.searchSATScoreViewModel = viewModel
        
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
        
        let searchTotalVC = SearchTotalScoreViewController(viewModel: SearchSATScoreViewModel(schools: searchSATScoreViewModel.schools, schoolScores: searchSATScoreViewModel.schoolsScores))
//        let topMathSchoolsVC = TopMathSchoolsViewController(viewModel: TopSchoolsViewModel(schools: topSchoolsViewModel.schools, schoolsScores: topSchoolsViewModel.schoolsScores))
//        let topReadingSchoolsVC = TopReadingSchoolsViewController(viewModel: TopSchoolsViewModel(schools: topSchoolsViewModel.schools, schoolsScores: topSchoolsViewModel.schoolsScores))
//        let topWritingSchoolsVC = TopWritingSchoolsViewController(viewModel: TopSchoolsViewModel(schools: topSchoolsViewModel.schools, schoolsScores: topSchoolsViewModel.schoolsScores))

        searchTotalVC.setTabBarImage(imageSFName: "list.dash.header.rectangle", title: "Top Schools", tag: 0)
//        topMathSchoolsVC.setTabBarImage(imageSFName: "arrow.left.arrow.right", title: "Top Math Schools", tag: 1)
//        topReadingSchoolsVC.setTabBarImage(imageSFName: "book", title: "Top Reading Schools", tag: 2)
//        topWritingSchoolsVC.setTabBarImage(imageSFName: "book", title: "Top Writing Schools", tag: 3)


        let searchTotalNC = UINavigationController(rootViewController: searchTotalVC)
//        let topMathSchoolsNC = UINavigationController(rootViewController: topMathSchoolsVC)
//        let topReadingSchoolsNC = UINavigationController(rootViewController: topReadingSchoolsVC)
//        let topWritingSchoolsNC = UINavigationController(rootViewController: topWritingSchoolsVC)
        
        let tabBarList = [searchTotalNC]

        viewControllers = tabBarList
    }

    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}

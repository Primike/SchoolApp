//
//  SchoolCalculatorTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class SearchScoresTabBarViewController: UITabBarController {
    
    let searchSATScoreViewModel: SearchScoresViewModel
    
    init(viewModel: SearchScoresViewModel) {
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
        
        let searchTotalVC = SearchTotalScoreViewController(viewModel: SearchScoresViewModel(schools: searchSATScoreViewModel.schools, schoolsScores: searchSATScoreViewModel.schoolsScores))
        let searchMathVC = SearchMathScoreViewController(viewModel: SearchScoresViewModel(schools: searchSATScoreViewModel.schools, schoolsScores: searchSATScoreViewModel.schoolsScores))
        let searchReadingVC = SearchReadingScoreViewController(viewModel: SearchScoresViewModel(schools: searchSATScoreViewModel.schools, schoolsScores: searchSATScoreViewModel.schoolsScores))
        let searchWritingVC = SearchWritingScoreViewController(viewModel: SearchScoresViewModel(schools: searchSATScoreViewModel.schools, schoolsScores: searchSATScoreViewModel.schoolsScores))

        searchTotalVC.setTabBarImage(imageSFName: "list.dash.header.rectangle", title: "Top Schools", tag: 0)
        searchMathVC.setTabBarImage(imageSFName: "arrow.left.arrow.right", title: "Top Math Schools", tag: 1)
        searchReadingVC.setTabBarImage(imageSFName: "book", title: "Top Reading Schools", tag: 2)
        searchWritingVC.setTabBarImage(imageSFName: "book", title: "Top Writing Schools", tag: 3)


        let searchTotalNC = UINavigationController(rootViewController: searchTotalVC)
        let searchMathNC = UINavigationController(rootViewController: searchMathVC)
        let searchReadingNC = UINavigationController(rootViewController: searchReadingVC)
        let searchWritingNC = UINavigationController(rootViewController: searchWritingVC)
        
        let tabBarList = [searchTotalNC, searchMathNC, searchReadingNC, searchWritingNC]

        viewControllers = tabBarList
    }

    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}

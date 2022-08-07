//
//  SchoolCalculatorTabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class SearchSATScoresTabBarViewController: UITabBarController {
    
    let searchSATScoresViewModel: SearchSATScoresViewModel
    
    init(viewModel: SearchSATScoresViewModel) {
        self.searchSATScoresViewModel = viewModel
        
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
        let searchTotalVC = SearchTotalScoreViewController(viewModel: SearchSATScoresViewModel(schools: searchSATScoresViewModel.schools, schoolsScores: searchSATScoresViewModel.schoolsScores))
        let searchMathVC = SearchMathScoreViewController(viewModel: SearchSATScoresViewModel(schools: searchSATScoresViewModel.schools, schoolsScores: searchSATScoresViewModel.schoolsScores))
        let searchReadingVC = SearchReadingScoreViewController(viewModel: SearchSATScoresViewModel(schools: searchSATScoresViewModel.schools, schoolsScores: searchSATScoresViewModel.schoolsScores))
        let searchWritingVC = SearchWritingScoreViewController(viewModel: SearchSATScoresViewModel(schools: searchSATScoresViewModel.schools, schoolsScores: searchSATScoresViewModel.schoolsScores))

        searchTotalVC.setTabBarImage(imageSFName: "star.fill", title: "SAT Score", tag: 0)
        searchMathVC.setTabBarImage(imageSFName: "x.squareroot", title: "Math Score", tag: 1)
        searchReadingVC.setTabBarImage(imageSFName: "book.fill", title: "Reading Score", tag: 2)
        searchWritingVC.setTabBarImage(imageSFName: "pencil", title: "Writing Score", tag: 3)

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

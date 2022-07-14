//
//  TabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/12/22.
//

import Foundation
import UIKit

class SchoolTabBarViewController: UITabBarController {

    var school: School
    var schoolScores: SchoolScores
    var scoresNotAvailable = [Int]()
    let schoolColor: UIColor
    
    init(school: School, scores: SchoolScores, schoolColor: UIColor) {
        self.school = school
        self.schoolScores = scores
        self.schoolColor = schoolColor
        
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
        
        let schoolInfoVC = SchoolInfoViewController(school: school, schoolColor: schoolColor)
        let satScoresVC = SchoolScoresViewController(school: school, scores: schoolScores, schoolColor: schoolColor)

        schoolInfoVC.setTabBarImage(imageSFName: "list.dash.header.rectangle", title: "Summary", tag: 0)
        satScoresVC.setTabBarImage(imageSFName: "arrow.left.arrow.right", title: "SAT Scores", tag: 1)

        let schoolInfoNC = UINavigationController(rootViewController: schoolInfoVC)
        let satScoresNC = UINavigationController(rootViewController: satScoresVC)
        
        let tabBarList = [schoolInfoNC, satScoresNC]

        viewControllers = tabBarList
    }

    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}



extension UIViewController {
    func setTabBarImage(imageSFName: String, title: String, tag: Int) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageSFName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    }
}



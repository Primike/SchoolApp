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
    var schoolColor = UIColor.systemBlue
    
    init(school: School, scores: SchoolScores) {
        self.school = school
        self.schoolScores = scores
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.schoolColor = self.getColor(school: school)
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        
        let schoolInfoVC = SchoolInfoViewController(school: school, schoolColor: schoolColor)
        let satScoresVC = SchoolScoresViewController(school: school, scores: schoolScores, schoolColor: schoolColor)
        let schoolMapVC = SchoolMapViewController(latitude: school.latitude!, longitude: school.longitude!, schoolName: school.school_name, schoolColor: getColor(school: school))

        schoolInfoVC.setTabBarImage(imageSFName: "list.dash.header.rectangle", title: "Summary", tag: 0)
        satScoresVC.setTabBarImage(imageSFName: "arrow.left.arrow.right", title: "SAT Scores", tag: 1)
        schoolMapVC.setTabBarImage(imageSFName: "checkmark", title: "School Map", tag: 2)

        let schoolInfoNC = UINavigationController(rootViewController: schoolInfoVC)
        let satScoresNC = UINavigationController(rootViewController: satScoresVC)
        let schoolMapNC = UINavigationController(rootViewController: schoolMapVC)
        
        let tabBarList = [schoolInfoNC, satScoresNC, schoolMapNC]

        viewControllers = tabBarList
    }

    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
    
    func getColor(school: School) -> UIColor {
        switch school.boro {
        case "M":
            return UIColor.systemBlue
        case "X":
            return .systemOrange
        case "K":
            return UIColor.black
        case "Q":
            return UIColor.systemPurple
        default:
            return .systemGreen
        }
    }
}



extension UIViewController {
    func setTabBarImage(imageSFName: String, title: String, tag: Int) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageSFName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    }
}



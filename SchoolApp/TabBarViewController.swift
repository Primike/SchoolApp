//
//  TabBarViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/12/22.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {

    var school: School
    var tests: SchoolScore
    var testScores = [Int]()
    
    init(school: School, tests: SchoolScore) {
        self.school = school
        self.tests = tests
        if tests.sat_math_avg_score != "Not Available" {
            testScores.append(Int(tests.sat_math_avg_score)!)
        }
        if tests.sat_writing_avg_score != "Not Available" {
            testScores.append(Int(tests.sat_writing_avg_score)!)
        }
        if tests.sat_critical_reading_avg_score != "Not Available" {
            testScores.append(Int(tests.sat_critical_reading_avg_score)!)
        }
        print(testScores)
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
        let summaryVC = InfoViewController(school: school, tests: tests)
        let satScoresVC = TestsViewController(school: school, tests: tests)
        let moreVC = ViewController()

        summaryVC.setTabBarImage(imageSFName: "list.dash.header.rectangle", title: "Summary", tag: 0)
        satScoresVC.setTabBarImage(imageSFName: "arrow.left.arrow.right", title: "SAT Scores", tag: 1)
        moreVC.setTabBarImage(imageSFName: "ellipsis.circle", title: "More", tag: 2)

        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let satScoresNC = UINavigationController(rootViewController: satScoresVC)
//        let moreNC = UINavigationController(rootViewController: moreVC)

        summaryNC.navigationBar.barTintColor = .white
        //the next four lines could be put into a method that just calls one line that passes the correct navigation bar.
        let img = UIImage()
        summaryNC.navigationBar.shadowImage = img
        summaryNC.navigationBar.setBackgroundImage(img, for: .default)
        summaryNC.navigationBar.isTranslucent = false
        
        
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC, satScoresNC]

        viewControllers = tabBarList
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
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
    
    func setStatusBar(){
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusBarView = UIView(frame: frame)
        
        statusBarView.backgroundColor = appColor
        view.addSubview(statusBarView)
    }
}



//
//  HomeViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let topView = UIView()
    let buttonsSubView = UIView()
    let wallpaper = UIImageView(image: UIImage(named: "schoolwallpaper"))
    let buttonsStackView = UIStackView()
    let schoolsListButton = UIButton()
    let topSchoolsButton = UIButton()
    let myschoolsButton = UIButton()
    let viewModel = SchoolsListViewModel()
    let titleStackView = UIStackView()
    let appTitle = UILabel()
    let divider = UILabel()
    let bottomView = UIView()
    let welcomeLabel = UILabel()
    let divider2 = UILabel()

    
    override func viewDidLoad() {
        style()
        layout()
        
        super.viewDidLoad()
    }
    
    func style() {

        topView.translatesAutoresizingMaskIntoConstraints = false
        wallpaper.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsSubView.translatesAutoresizingMaskIntoConstraints = false
        buttonsSubView.layer.cornerRadius = 70
        buttonsSubView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        buttonsSubView.backgroundColor = UIColor.systemRed
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .vertical
        
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .vertical
        
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        appTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        appTitle.text = "Schools App"
        appTitle.textColor = .white
        appTitle.adjustsFontSizeToFitWidth = true
        appTitle.textAlignment = .center
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        
        
        
        schoolsListButton.translatesAutoresizingMaskIntoConstraints = false
        schoolsListButton.addTarget(self, action: #selector(graphButtonTapped), for: .primaryActionTriggered)
        schoolsListButton.tintColor = .white
        schoolsListButton.backgroundColor = .white
        schoolsListButton.setTitleColor(.black, for: .normal)
        schoolsListButton.setTitle("NYC Schools List", for: .normal)
        schoolsListButton.titleLabel!.font = UIFont(name:"HelveticaNeue", size: 23.0)
        schoolsListButton.titleLabel!.adjustsFontSizeToFitWidth = true
        schoolsListButton.layer.cornerRadius = 10

        topSchoolsButton.translatesAutoresizingMaskIntoConstraints = false
        topSchoolsButton.addTarget(self, action: #selector(graphButtonTapped), for: .primaryActionTriggered)
        topSchoolsButton.tintColor = .white
        topSchoolsButton.backgroundColor = .white
        topSchoolsButton.setTitleColor(.black, for: .normal)
        topSchoolsButton.setTitle("Top 10 SAT Schools", for: .normal)
        topSchoolsButton.titleLabel!.font = UIFont(name:"HelveticaNeue", size: 23.0)
        topSchoolsButton.titleLabel!.adjustsFontSizeToFitWidth = true
        topSchoolsButton.layer.cornerRadius = 10
        
        myschoolsButton.translatesAutoresizingMaskIntoConstraints = false
        myschoolsButton.addTarget(self, action: #selector(graphButtonTapped), for: .primaryActionTriggered)
        myschoolsButton.tintColor = .white
        myschoolsButton.backgroundColor = .white
        myschoolsButton.setTitleColor(.black, for: .normal)
        myschoolsButton.setTitle("My Schools", for: .normal)
        myschoolsButton.titleLabel!.font = UIFont(name:"HelveticaNeue", size: 23.0)
        myschoolsButton.titleLabel!.adjustsFontSizeToFitWidth = true
        myschoolsButton.layer.cornerRadius = 10
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.layer.cornerRadius = 70
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.backgroundColor = UIColor.white
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        welcomeLabel.text = "Welcome"
        welcomeLabel.textColor = .systemRed
        welcomeLabel.adjustsFontSizeToFitWidth = true
        welcomeLabel.textAlignment = .center
        
        divider2.translatesAutoresizingMaskIntoConstraints = false
        divider2.backgroundColor = .systemRed
        
    }
    
    func layout() {
        topView.addSubview(wallpaper)
        
        titleStackView.addSubview(appTitle)
        titleStackView.addSubview(divider)
        
        buttonsStackView.addSubview(schoolsListButton)
        buttonsStackView.addSubview(topSchoolsButton)
        buttonsStackView.addSubview(myschoolsButton)
        
        buttonsSubView.addSubview(titleStackView)
        buttonsSubView.addSubview(buttonsStackView)
        
        bottomView.addSubview(welcomeLabel)
        bottomView.addSubview(divider2)
        
        view.addSubview(topView)
        view.addSubview(buttonsSubView)
        view.addSubview(bottomView)
        
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            wallpaper.topAnchor.constraint(equalTo: topView.topAnchor),
            wallpaper.widthAnchor.constraint(equalTo: topView.widthAnchor),
            wallpaper.heightAnchor.constraint(equalTo: topView.heightAnchor),
            wallpaper.leftAnchor.constraint(equalTo: topView.leftAnchor),
            
            buttonsSubView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonsSubView.leftAnchor.constraint(equalTo: view.leftAnchor),
            buttonsSubView.rightAnchor.constraint(equalTo: view.rightAnchor),
            buttonsSubView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            
            
            titleStackView.topAnchor.constraint(equalTo: buttonsSubView.topAnchor),
            titleStackView.widthAnchor.constraint(equalTo: buttonsSubView.widthAnchor, multiplier: 0.8),
            titleStackView.heightAnchor.constraint(equalTo: buttonsSubView.heightAnchor, multiplier: 0.2),
            titleStackView.centerXAnchor.constraint(equalTo: buttonsSubView.centerXAnchor),
            
            appTitle.centerYAnchor.constraint(equalTo: titleStackView.centerYAnchor),
            appTitle.centerXAnchor.constraint(equalTo: titleStackView.centerXAnchor),
            
            divider.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 10),
            divider.widthAnchor.constraint(equalTo: titleStackView.widthAnchor),
            divider.centerXAnchor.constraint(equalTo: titleStackView.centerXAnchor),
            divider.heightAnchor.constraint(equalToConstant: 5),
            
            buttonsStackView.heightAnchor.constraint(equalTo: buttonsSubView.heightAnchor, multiplier: 0.4),
            buttonsStackView.widthAnchor.constraint(equalTo: buttonsSubView.widthAnchor, multiplier: 0.7),
            buttonsStackView.centerXAnchor.constraint(equalTo: buttonsSubView.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: buttonsSubView.centerYAnchor),
            
            schoolsListButton.topAnchor.constraint(equalTo: buttonsStackView.topAnchor),
            schoolsListButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            schoolsListButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.25),
            
            topSchoolsButton.centerYAnchor.constraint(equalTo: buttonsStackView.centerYAnchor),
            topSchoolsButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            topSchoolsButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.25),
            
            myschoolsButton.bottomAnchor.constraint(equalTo: buttonsStackView.bottomAnchor),
            myschoolsButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            myschoolsButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.25),
            
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalTo: buttonsSubView.heightAnchor, multiplier: 0.2),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            welcomeLabel.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.5),
            welcomeLabel.topAnchor.constraint(equalTo: bottomView.topAnchor),
            
            divider2.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 5),
            divider2.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            divider2.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.8),
            
        ])
    }
}

extension HomeViewController {
    @objc func graphButtonTapped(sender: UIButton) {
        
//        let defaults = UserDefaults.standard
//        if let stringOne = defaults.array(forKey: DefaultsKeys.two){
//            print(stringOne, "ASDSADASD") // Some String Value
//        }
        navigationController?.pushViewController(SchoolsListViewController(viewModel: SchoolsListViewModel()), animated: true)
    }
}


struct DefaultsKeys {
    static let one = [String]()
    static let two = "QWE"
}


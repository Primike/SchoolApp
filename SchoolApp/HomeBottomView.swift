//
//  HomeBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class HomeBottomView: UIView {
    
    var parentViewWidth: CGFloat
    
    init(viewWidth: CGFloat) {
        self.parentViewWidth = viewWidth
        
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var appTitleLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Schools App", labelTextColor: .white)
        return label
    }()
    
    lazy var divider: UILabel = {
        var divider = UILabel()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        return divider
    }()
    
    lazy var schoolsListStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var schoolsListButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "NYC Schools List", viewWidth: parentViewWidth, imageName: "list.star", titleSize: 17, imageSize: 18)
        button.tag = 0
        return button
    }()

    lazy var mapSearchStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var mapSearchButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "Map Search", viewWidth: parentViewWidth, imageName: "map", titleSize: 17, imageSize: 18)
        button.tag = 1
        return button
    }()

    lazy var mySchoolsStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var myschoolsButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "My Schools", viewWidth: parentViewWidth, imageName: "bolt.heart", titleSize: 17, imageSize: 18)
        button.tag = 2
        return button
    }()

    lazy var smallButtonsStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var topSchoolsButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "Top Schools", viewWidth: parentViewWidth, imageName: "star", titleSize: 30, imageSize: 32)
        button.tag = 3
        return button
    }()

    lazy var satSearchButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "SAT Search", viewWidth: parentViewWidth, imageName: "books.vertical", titleSize: 30, imageSize: 32)
        button.tag = 4
        return button
    }()

    lazy var bottomStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.layer.cornerRadius = 70
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.backgroundColor = UIColor.white
        return stackView
    }()
    
    lazy var welcomeLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Welcome", labelTextColor: .black)
        return label
    }()
    
    lazy var divider2: UILabel = {
        var divider = UILabel()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .black
        return divider
    }()
        
    private func layout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleStackView)
        self.addSubview(schoolsListStackView)
        self.addSubview(mapSearchStackView)
        self.addSubview(mySchoolsStackView)
        self.addSubview(smallButtonsStackView)
        self.addSubview(bottomStackView)
        
        titleStackView.addSubview(appTitleLabel)
        titleStackView.addSubview(divider)
        
        schoolsListStackView.addSubview(schoolsListButton)
        mapSearchStackView.addSubview(mapSearchButton)
        mySchoolsStackView.addSubview(myschoolsButton)
        smallButtonsStackView.addSubview(topSchoolsButton)
        smallButtonsStackView.addSubview(satSearchButton)
        
        bottomStackView.addSubview(welcomeLabel)
        bottomStackView.addSubview(divider2)
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: self.topAnchor),
            titleStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            titleStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            titleStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            appTitleLabel.topAnchor.constraint(equalTo: titleStackView.topAnchor),
            appTitleLabel.heightAnchor.constraint(equalTo: titleStackView.heightAnchor, multiplier: 0.7),
            appTitleLabel.widthAnchor.constraint(equalTo: titleStackView.widthAnchor, multiplier: 0.9),
            appTitleLabel.centerXAnchor.constraint(equalTo: titleStackView.centerXAnchor),
            
            divider.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 5),
            divider.widthAnchor.constraint(equalTo: titleStackView.widthAnchor),
            divider.centerXAnchor.constraint(equalTo: titleStackView.centerXAnchor),
            
            schoolsListStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
            schoolsListStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            schoolsListStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            schoolsListStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            schoolsListButton.heightAnchor.constraint(equalTo: schoolsListStackView.heightAnchor, multiplier: 0.8),
            schoolsListButton.widthAnchor.constraint(equalTo: schoolsListStackView.widthAnchor),
            schoolsListButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            schoolsListButton.centerYAnchor.constraint(equalTo: schoolsListStackView.centerYAnchor),

            mapSearchStackView.topAnchor.constraint(equalTo: schoolsListStackView.bottomAnchor),
            mapSearchStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            mapSearchStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            mapSearchStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            mapSearchButton.heightAnchor.constraint(equalTo: mapSearchStackView.heightAnchor, multiplier: 0.8),
            mapSearchButton.widthAnchor.constraint(equalTo: mapSearchStackView.widthAnchor),
            mapSearchButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mapSearchButton.centerYAnchor.constraint(equalTo: mapSearchStackView.centerYAnchor),
            
            mySchoolsStackView.topAnchor.constraint(equalTo: mapSearchStackView.bottomAnchor),
            mySchoolsStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            mySchoolsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            mySchoolsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            myschoolsButton.heightAnchor.constraint(equalTo: mySchoolsStackView.heightAnchor, multiplier: 0.8),
            myschoolsButton.widthAnchor.constraint(equalTo: mySchoolsStackView.widthAnchor),
            myschoolsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            myschoolsButton.centerYAnchor.constraint(equalTo: mySchoolsStackView.centerYAnchor),

            smallButtonsStackView.topAnchor.constraint(equalTo: mySchoolsStackView.bottomAnchor),
            smallButtonsStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            smallButtonsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            smallButtonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            topSchoolsButton.leftAnchor.constraint(equalTo: smallButtonsStackView.leftAnchor),
            topSchoolsButton.heightAnchor.constraint(equalTo: smallButtonsStackView.heightAnchor, multiplier: 0.6),
            topSchoolsButton.widthAnchor.constraint(equalTo: smallButtonsStackView.widthAnchor, multiplier: 0.48),
            topSchoolsButton.centerYAnchor.constraint(equalTo: smallButtonsStackView.centerYAnchor),
            
            satSearchButton.rightAnchor.constraint(equalTo: smallButtonsStackView.rightAnchor),
            satSearchButton.heightAnchor.constraint(equalTo: smallButtonsStackView.heightAnchor, multiplier: 0.6),
            satSearchButton.widthAnchor.constraint(equalTo: smallButtonsStackView.widthAnchor, multiplier: 0.48),
            satSearchButton.centerYAnchor.constraint(equalTo: smallButtonsStackView.centerYAnchor),

            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            bottomStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            bottomStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: bottomStackView.topAnchor),
            welcomeLabel.heightAnchor.constraint(equalTo: bottomStackView.heightAnchor, multiplier: 0.5),
            welcomeLabel.widthAnchor.constraint(equalTo: bottomStackView.widthAnchor, multiplier: 0.8),
            welcomeLabel.centerXAnchor.constraint(equalTo: bottomStackView.centerXAnchor),
            
            divider2.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 5),
            divider2.widthAnchor.constraint(equalTo: bottomStackView.widthAnchor, multiplier: 0.8),
            divider2.centerXAnchor.constraint(equalTo: bottomStackView.centerXAnchor),
        ])
    }
}

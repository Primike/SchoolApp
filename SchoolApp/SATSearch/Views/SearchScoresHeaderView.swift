//
//  SearchSATScoresView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class SearchScoresHeaderView: UIView {
    lazy var titleLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Search Schools By SAT Score", labelTextColor: .white)
        label.numberOfLines = 1
        return label
    }()

    lazy var headerStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
        
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Combined", "Math", "Reading", "Writing"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = .white
        return segmentedControl
    }()

    lazy var searchStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var scoreStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var scoreLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Score", labelTextColor: .white)
        return label
    }()

    lazy var numberStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var numberOfSchoolsLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Schools", labelTextColor: .white)
        return label
    }()
    
    lazy var totalScoreText: SchoolAppTextField = {
        var textField = SchoolAppTextField()
        return textField
    }()

    lazy var schoolNumberText: SchoolAppTextField = {
        var textField = SchoolAppTextField()
        return textField
    }()

    lazy var errorLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "qweqwe", labelTextColor: .systemRed)
        label.isHidden = true
        return label
    }()

    lazy var searchButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "Search", viewWidth: parentViewWidth, imageName: "magnifyingglass", titleSize: 38, imageSize: 35)
        return button
    }()

    let parentViewWidth: CGFloat
    
    init(viewWidth: CGFloat) {
        self.parentViewWidth = viewWidth
        
        super.init(frame: .zero)
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 40
        self.layer.maskedCorners = [.layerMinXMaxYCorner]

        self.addSubview(headerStackView)
        
        headerStackView.addSubview(titleLabel)
        headerStackView.addSubview(segmentedControl)
        headerStackView.addSubview(searchStackView)
        headerStackView.addSubview(errorLabel)
        
        searchStackView.addSubview(scoreStackView)
        searchStackView.addSubview(numberStackView)
        searchStackView.addSubview(searchButton)
        
        scoreStackView.addSubview(scoreLabel)
        scoreStackView.addSubview(totalScoreText)
        numberStackView.addSubview(numberOfSchoolsLabel)
        numberStackView.addSubview(schoolNumberText)

        NSLayoutConstraint.activate([
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.95),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            titleLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.3),
            titleLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            segmentedControl.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.20),
            segmentedControl.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 1),
            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            searchStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.35),
            searchStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor),
            searchStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            searchStackView.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            scoreStackView.topAnchor.constraint(equalTo: searchStackView.topAnchor),
            scoreStackView.leftAnchor.constraint(equalTo: searchStackView.leftAnchor),
            scoreStackView.heightAnchor.constraint(equalTo: searchStackView.heightAnchor),
            scoreStackView.widthAnchor.constraint(equalTo: searchStackView.widthAnchor, multiplier: 0.3),
            
            scoreLabel.topAnchor.constraint(equalTo: scoreStackView.topAnchor),
            scoreLabel.leftAnchor.constraint(equalTo: scoreStackView.leftAnchor),
            scoreLabel.heightAnchor.constraint(equalTo: scoreStackView.heightAnchor),
            scoreLabel.widthAnchor.constraint(equalTo: scoreStackView.widthAnchor, multiplier: 0.45),

            totalScoreText.centerYAnchor.constraint(equalTo: scoreStackView.centerYAnchor),
            totalScoreText.rightAnchor.constraint(equalTo: scoreStackView.rightAnchor),
            totalScoreText.heightAnchor.constraint(equalTo: scoreStackView.heightAnchor, multiplier: 0.6),
            totalScoreText.widthAnchor.constraint(equalTo: scoreStackView.widthAnchor, multiplier: 0.5),
            
            numberStackView.topAnchor.constraint(equalTo: searchStackView.topAnchor),
            numberStackView.centerXAnchor.constraint(equalTo: searchStackView.centerXAnchor),
            numberStackView.heightAnchor.constraint(equalTo: searchStackView.heightAnchor),
            numberStackView.widthAnchor.constraint(equalTo: searchStackView.widthAnchor, multiplier: 0.35),
                        
            numberOfSchoolsLabel.topAnchor.constraint(equalTo: numberStackView.topAnchor),
            numberOfSchoolsLabel.leftAnchor.constraint(equalTo: numberStackView.leftAnchor),
            numberOfSchoolsLabel.heightAnchor.constraint(equalTo: numberStackView.heightAnchor),
            numberOfSchoolsLabel.widthAnchor.constraint(equalTo: numberStackView.widthAnchor, multiplier: 0.45),

            schoolNumberText.centerYAnchor.constraint(equalTo: numberStackView.centerYAnchor),
            schoolNumberText.rightAnchor.constraint(equalTo: numberStackView.rightAnchor),
            schoolNumberText.heightAnchor.constraint(equalTo: numberStackView.heightAnchor, multiplier: 0.6),
            schoolNumberText.widthAnchor.constraint(equalTo: numberStackView.widthAnchor, multiplier: 0.5),

            searchButton.centerYAnchor.constraint(equalTo: searchStackView.centerYAnchor),
            searchButton.rightAnchor.constraint(equalTo: searchStackView.rightAnchor),
            searchButton.heightAnchor.constraint(equalTo: searchStackView.heightAnchor, multiplier: 0.6),
            searchButton.widthAnchor.constraint(equalTo: searchStackView.widthAnchor, multiplier: 0.25),
            
            errorLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.15),
            errorLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.8),
            errorLabel.topAnchor.constraint(equalTo: searchStackView.bottomAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),

        ])
    }
}

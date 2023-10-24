//
//  HomeBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class HomeBottomView: UIView {
    
    private let parentViewWidth: CGFloat
    
    init(viewWidth: CGFloat) {
        self.parentViewWidth = viewWidth
        
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var appTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 100)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "High School Hunt NYC"
        let attributedString = NSMutableAttributedString(string: "High School Hunt NYC")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: "High School Hunt NYC".count))
        label.attributedText = attributedString
        return label

    }()
        
    //MARK: LARGE BUTTONS
    lazy var largeButtonsStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()

    lazy var schoolsListButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "NYC Schools List", viewWidth: parentViewWidth, imageName: "list.star", titleSize: 17, imageSize: 18)
        button.tag = ViewControllerType.schoolsList.rawValue
        return button
    }()

    lazy var mapSearchButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "Map Search", viewWidth: parentViewWidth, imageName: "map", titleSize: 17, imageSize: 18)
        button.tag = ViewControllerType.mapSearch.rawValue
        return button

    }()

    lazy var myschoolsButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "My Schools", viewWidth: parentViewWidth, imageName: "bolt.heart", titleSize: 17, imageSize: 18)
        button.tag = ViewControllerType.mySchools.rawValue
        return button
    }()
    
    lazy var about: SchoolAppButton = {
        let button = SchoolAppButton(title: "About", viewWidth: parentViewWidth, imageName: "questionmark.circle", titleSize: 17, imageSize: 18)
        button.tag = ViewControllerType.mySchools.rawValue
        return button
    }()

    //MARK: BOTTOM VIEW
    lazy var bottomStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.layer.cornerRadius = 40
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.backgroundColor = UIColor.white
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Welcome"
        return label
    }()
    
    private func layout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(appTitleLabel)
        self.addSubview(largeButtonsStackView)
        self.addSubview(bottomStackView)
        
        largeButtonsStackView.addArrangedSubview(schoolsListButton)
        largeButtonsStackView.addArrangedSubview(mapSearchButton)
        largeButtonsStackView.addArrangedSubview(myschoolsButton)
        largeButtonsStackView.addArrangedSubview(about)
        bottomStackView.addArrangedSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            appTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            appTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20),
            appTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            appTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            largeButtonsStackView.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor),
            largeButtonsStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            largeButtonsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            largeButtonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            bottomStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            bottomStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

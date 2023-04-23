//
//  TopSchoolsHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/21/23.
//

import Foundation
import UIKit
class TopSchoolsHeaderView: UIView {
    
    lazy var headerStackView: SchoolAppStackView = {
        let stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var searchStackView: SchoolAppStackView = {
        let stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var titleLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Search Top Schools", labelTextColor: .black)
        return label
    }()

    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Combined", "Math", "Reading", "Writing"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = .white
        return segmentedControl
    }()
    
    lazy var numberTextField: SchoolAppTextField = {
        let textField = SchoolAppTextField()
        return textField
    }()
    
    lazy var errorLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "qweqwe", labelTextColor: .systemRed)
        label.isHidden = true
        return label
    }()

    lazy var searchButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "Search", viewWidth: self.bounds.width, imageName: "magnifyingglass", titleSize: 19, imageSize: 22)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(headerStackView)
        
        headerStackView.addSubview(titleLabel)
        headerStackView.addSubview(segmentedControl)
        headerStackView.addSubview(searchStackView)
        headerStackView.addSubview(errorLabel)
        
        searchStackView.addSubview(numberTextField)
        searchStackView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.95),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            titleLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.3),
            titleLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.8),
            titleLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            segmentedControl.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.25),
            segmentedControl.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 1),
            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),

            searchStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.3),
            searchStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.9),
            searchStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            searchStackView.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),

            numberTextField.heightAnchor.constraint(equalTo: searchStackView.heightAnchor, multiplier: 0.7),
            numberTextField.widthAnchor.constraint(equalTo: searchStackView.widthAnchor, multiplier: 0.6),
            numberTextField.bottomAnchor.constraint(equalTo: searchStackView.bottomAnchor),
            numberTextField.leftAnchor.constraint(equalTo: searchStackView.leftAnchor),

            searchButton.heightAnchor.constraint(equalTo: searchStackView.heightAnchor, multiplier: 0.7),
            searchButton.widthAnchor.constraint(equalTo: searchStackView.widthAnchor, multiplier: 0.3),
            searchButton.bottomAnchor.constraint(equalTo: searchStackView.bottomAnchor),
            searchButton.rightAnchor.constraint(equalTo: searchStackView.rightAnchor),

            errorLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.15),
            errorLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.8),
            errorLabel.topAnchor.constraint(equalTo: searchStackView.bottomAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
        ])
    }
}

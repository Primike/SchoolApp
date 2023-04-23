////
////  NearbySchoolsHeaderView.swift
////  SchoolApp
////
////  Created by Prince Avecillas on 7/25/22.
////
//
//import Foundation
//import UIKit
//
//class NearbySchoolsHeaderView: UIView {
//    
//    lazy var headerStackView: SchoolAppStackView = {
//        var stackView = SchoolAppStackView()
//        return stackView
//    }()
//    
//    let headerLabel = UILabel()
//    let findLabel = UILabel()
//    let nearestLabel = UILabel()
//    let errorLabel = UILabel()
//    
//    lazy var middleStackView: SchoolAppStackView = {
//        var stackView = SchoolAppStackView()
//        return stackView
//    }()
//    lazy var inputStackView: SchoolAppStackView = {
//        var stackView = SchoolAppStackView()
//        return stackView
//    }()
//    lazy var buttonStackView: SchoolAppStackView = {
//        var stackView = SchoolAppStackView()
//        return stackView
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        setup()
//        layout()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//         super.init(coder: aDecoder)
//    }
//    
//    func setup() {
////        headerStackView.translatesAutoresizingMaskIntoConstraints = false
////        headerStackView.axis = .vertical
////
////        middleStackView.translatesAutoresizingMaskIntoConstraints = false
////        middleStackView.axis = .horizontal
////
////        inputStackView.translatesAutoresizingMaskIntoConstraints = false
////        inputStackView.axis = .horizontal
////
////        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        headerLabel.translatesAutoresizingMaskIntoConstraints = false
//        headerLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
//        headerLabel.adjustsFontSizeToFitWidth = true
//        headerLabel.textAlignment = .center
//        headerLabel.text = "Search Nearest Schools"
//        headerLabel.textColor = .white
//        headerLabel.numberOfLines = 0
//        
//        findLabel.translatesAutoresizingMaskIntoConstraints = false
//        findLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
//        findLabel.adjustsFontSizeToFitWidth = true
//        findLabel.textAlignment = .center
//        findLabel.text = "Find"
//        findLabel.textColor = .white
//        findLabel.numberOfLines = 0
//        
//        nearestLabel.translatesAutoresizingMaskIntoConstraints = false
//        nearestLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
//        nearestLabel.adjustsFontSizeToFitWidth = true
//        nearestLabel.textAlignment = .center
//        nearestLabel.text = "Nearest Schools"
//        nearestLabel.textColor = .white
//        nearestLabel.numberOfLines = 0
//        
//        errorLabel.translatesAutoresizingMaskIntoConstraints = false
//        errorLabel.textAlignment = .center
//        errorLabel.font = UIFont(name:"HelveticaNeue-bold", size: 100.0)
//        errorLabel.adjustsFontSizeToFitWidth = true
//        errorLabel.numberOfLines = 0
//        errorLabel.textColor = .systemRed
//        errorLabel.isHidden = true
//    }
//    
//    func layout() {
//        self.addSubview(headerStackView)
//        headerStackView.addSubview(headerLabel)
//        headerStackView.addSubview(middleStackView)
//        headerStackView.addSubview(errorLabel)
//        
//        middleStackView.addSubview(inputStackView)
//        middleStackView.addSubview(buttonStackView)
//        
//        inputStackView.addSubview(findLabel)
//        inputStackView.addSubview(nearestLabel)
//        
//        NSLayoutConstraint.activate([
//            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
//            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
//            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            
//            headerLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
//            headerLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.2),
//            headerLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.9),
//            headerLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
//            
//            middleStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
//            middleStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.5),
//            middleStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.9),
//            middleStackView.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
//            
//            inputStackView.topAnchor.constraint(equalTo: middleStackView.topAnchor),
//            inputStackView.leftAnchor.constraint(equalTo: middleStackView.leftAnchor),
//            inputStackView.heightAnchor.constraint(equalTo: middleStackView.heightAnchor),
//            inputStackView.widthAnchor.constraint(equalTo: middleStackView.widthAnchor, multiplier: 0.7),
//            
//            findLabel.topAnchor.constraint(equalTo: inputStackView.topAnchor),
//            findLabel.leftAnchor.constraint(equalTo: inputStackView.leftAnchor),
//            findLabel.heightAnchor.constraint(equalTo: inputStackView.heightAnchor),
//            findLabel.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.3),
//            
//            nearestLabel.topAnchor.constraint(equalTo: inputStackView.topAnchor),
//            nearestLabel.rightAnchor.constraint(equalTo: inputStackView.rightAnchor),
//            nearestLabel.heightAnchor.constraint(equalTo: inputStackView.heightAnchor),
//            nearestLabel.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.3),
//            
//            buttonStackView.topAnchor.constraint(equalTo: middleStackView.topAnchor),
//            buttonStackView.rightAnchor.constraint(equalTo: middleStackView.rightAnchor),
//            buttonStackView.heightAnchor.constraint(equalTo: middleStackView.heightAnchor),
//            buttonStackView.widthAnchor.constraint(equalTo: middleStackView.widthAnchor, multiplier: 0.25),
//            
//            errorLabel.topAnchor.constraint(equalTo: middleStackView.bottomAnchor),
//            errorLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.3),
//            errorLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.9),
//            errorLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
//        ])
//    }
//}


//class TopSchoolsHeaderViewa: UIView {
//    
//    lazy var headerStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.distribution = .equalSpacing
//        stackView.alignment = .center
//        return stackView
//    }()
//    
//    lazy var filterStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .horizontal
//        stackView.distribution = .equalSpacing
//        stackView.alignment = .center
//        stackView.spacing = 30
//        return stackView
//    }()
//
//    lazy var segmentedControl: UISegmentedControl = {
//        let items = ["Math", "Reading", "Writing", "Combined"]
//        let segmentedControl = UISegmentedControl(items: items)
//        segmentedControl.selectedSegmentIndex = 3
//        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        segmentedControl.backgroundColor = .white
//        return segmentedControl
//    }()
//    
//    lazy var numberOfSchoolsText: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.borderStyle = .roundedRect
//        textField.placeholder = "Number of schools"
//        textField.keyboardType = .numberPad
//        return textField
//    }()
//    lazy var errorLabel: SchoolAppLabel = {
//        var label = SchoolAppLabel(frame: CGRect(), labelText: "", labelTextColor: .systemRed)
//        label.isHidden = false
//        label.text = "QWEQWE"
//        label.font = UIFont.preferredFont(forTextStyle: .body)
//        label.adjustsFontForContentSizeCategory = true
//        return label
//    }()
//
//    lazy var submitButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Submit", for: .normal)
//        button.backgroundColor = .black
//        return button
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        layout()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func layout() {
//        self.backgroundColor = .systemBlue
//        addSubview(headerStackView)
//        
//        headerStackView.addArrangedSubview(segmentedControl)
//        headerStackView.addArrangedSubview(filterStackView)
//        headerStackView.addArrangedSubview(errorLabel)
//        
//        filterStackView.addArrangedSubview(numberOfSchoolsText)
//        filterStackView.addArrangedSubview(submitButton)
//        
//        let isRegularWidth = traitCollection.horizontalSizeClass == .regular
//
//        let numberOfSchoolsTextWidthConstraint = numberOfSchoolsText.widthAnchor.constraint(equalTo: filterStackView.widthAnchor, multiplier: isRegularWidth ? 0.6 : 0.7)
//        numberOfSchoolsTextWidthConstraint.priority = UILayoutPriority(rawValue: 999)
//
//        let submitButtonWidthConstraint = submitButton.widthAnchor.constraint(equalTo: filterStackView.widthAnchor, multiplier: isRegularWidth ? 0.4 : 0.3)
//        submitButtonWidthConstraint.priority = UILayoutPriority(rawValue: 999)
//            
//        NSLayoutConstraint.activate([
//            headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
//            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            
//            numberOfSchoolsTextWidthConstraint,
//            submitButtonWidthConstraint,
//        ])
//        
//        if isRegularWidth {
//            let fontSize: CGFloat = 24
//            numberOfSchoolsText.font = UIFont.systemFont(ofSize: fontSize)
//            submitButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
//            segmentedControl.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: fontSize)], for: .normal)
//            errorLabel.font = UIFont.systemFont(ofSize: fontSize)
//        }
//    }
//}
//

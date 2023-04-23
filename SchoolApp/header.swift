////
////  header.swift
////  SchoolApp
////
////  Created by Prince Avecillas on 4/21/23.
////
//
//import Foundation
//import UIKit
//
//class SearchHeaderView: UIView {
//    
//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        label.textColor = .white
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    lazy var segmentedControl: UISegmentedControl = {
//        let items = ["Total", "Math", "Reading", "Writing"]
//        let segmentedControl = UISegmentedControl(items: items)
//        segmentedControl.selectedSegmentIndex = 0
//        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        return segmentedControl
//    }()
//    
//    lazy var totalScoreTextField: UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .roundedRect
//        textField.placeholder = "Total Score"
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    lazy var schoolNumberTextField: UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .roundedRect
//        textField.placeholder = "Number of Schools"
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    lazy var submitButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Submit", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        setupLayout()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupLayout() {
//        addSubview(titleLabel)
//        addSubview(segmentedControl)
//        addSubview(totalScoreTextField)
//        addSubview(schoolNumberTextField)
//        addSubview(submitButton)
//        
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            
//            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
//            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
//            
//            totalScoreTextField.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
//            totalScoreTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            
//            schoolNumberTextField.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
//            schoolNumberTextField.leadingAnchor.constraint(equalTo: totalScoreTextField.trailingAnchor, constant: 8),
//            schoolNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//            schoolNumberTextField.widthAnchor.constraint(equalTo: totalScoreTextField.widthAnchor),
//            
//            submitButton.topAnchor.constraint(equalTo: totalScoreTextField.bottomAnchor, constant: 8),
//            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            submitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
//        ])
//    }
//}

//
//  view.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/21/23.
//

import Foundation
import UIKit
class TopSchoolsHeaderViewa: UIView {
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Math", "Reading", "Writing", "Combined"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 3
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    lazy var numberOfSchoolsText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Number of schools"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(headerStackView)
        
        headerStackView.addArrangedSubview(segmentedControl)
        headerStackView.addArrangedSubview(filterStackView)
        
        filterStackView.addArrangedSubview(numberOfSchoolsText)
        filterStackView.addArrangedSubview(submitButton)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

//
//  MapFilterView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 10/21/23.
//

import Foundation
import UIKit

class MapFilterView: UIView {
    
    init() {
        super.init(frame: .zero)

        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    // MARK: - ADDRESS
    lazy var addressStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    lazy var addressLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.text = "Address:"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    lazy var addressText: UITextField = {
        var textField = UITextField()
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .title1).pointSize
        textField.font = UIFont(name: "HelveticaNeue", size: largeTitlePointSize)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 3.0
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.placeholder = " Default: Current Location  "

        return textField
    }()

    // MARK: - MILES
    lazy var milesStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var milesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue", size: largeTitlePointSize)
        label.text = "5 Miles"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    lazy var milesSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 25
        slider.value = 5
        return slider
    }()
    
    // MARK: - NUMBER OF SCHOOLS
    lazy var schoolNumberStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var maxNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue", size: largeTitlePointSize)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Maximum Schools:"
        return label
    }()
    
    lazy var numberPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    // MARK: - SUBJECT TYPE
    lazy var filterByScoreLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        label.text = "Filter By Section And Score:"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
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
    
    // MARK: MINIMUM SCORE
    lazy var minScoreStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var minScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont(name: "HelveticaNeue", size: largeTitlePointSize)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Minimum Score:"
        return label
    }()
    
    lazy var minScorePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    // MARK: - BUTTON
    
    lazy var applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = UIColor.black
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 5
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .title3).pointSize
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: largeTitlePointSize)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    private func layout() {
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(addressStackView)
        addressStackView.addSubview(addressLabel)
        addressStackView.addSubview(addressText)

        stackView.addArrangedSubview(milesStackView)
        milesStackView.addArrangedSubview(milesLabel)
        milesStackView.addArrangedSubview(milesSlider)
        
        stackView.addArrangedSubview(schoolNumberStackView)
        schoolNumberStackView.addArrangedSubview(maxNumberLabel)
        schoolNumberStackView.addArrangedSubview(numberPicker)

        stackView.addArrangedSubview(filterByScoreLabel)
        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(minScoreStackView)
        minScoreStackView.addArrangedSubview(minScoreLabel)
        minScoreStackView.addArrangedSubview(minScorePicker)
        
        stackView.addArrangedSubview(applyButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            addressStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.10),
            milesStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.10),
            segmentedControl.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.05),
            numberPicker.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.20),
            minScorePicker.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.20),
            
            addressLabel.widthAnchor.constraint(equalTo: addressStackView.widthAnchor, multiplier: 0.35),
            addressLabel.leftAnchor.constraint(equalTo: addressStackView.leftAnchor),
            addressText.widthAnchor.constraint(equalTo: addressStackView.widthAnchor, multiplier: 0.6),
            addressText.rightAnchor.constraint(equalTo: addressStackView.rightAnchor),
            
            applyButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.05),
            applyButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])

    }
}

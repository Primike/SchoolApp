//
//  NearbySchoolsHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class AddressSearchHeaderView: UIView {
    
    lazy var headerStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var addressHeaderLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Search Nearby Schools By Address", labelTextColor: .white)
        return label
    }()
    
    lazy var schoolNumberStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var findLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Find", labelTextColor: .white)
        return label
    }()
    
    lazy var nearestLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Nearest Schools", labelTextColor: .white)
        return label
    }()
    
    lazy var addressStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var addressLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Address:", labelTextColor: .white)
        return label
    }()

    lazy var errorLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Error Label", labelTextColor: .systemRed)
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
        
    private func layout() {
        self.addSubview(headerStackView)
        
        headerStackView.addSubview(addressHeaderLabel)
        headerStackView.addSubview(schoolNumberStackView)
        headerStackView.addSubview(addressStackView)
        headerStackView.addSubview(errorLabel)
        
        schoolNumberStackView.addSubview(findLabel)
        schoolNumberStackView.addSubview(nearestLabel)
        
        addressStackView.addSubview(addressLabel)

        NSLayoutConstraint.activate([
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            addressHeaderLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            addressHeaderLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.15),
            addressHeaderLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.8),
            addressHeaderLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            schoolNumberStackView.bottomAnchor.constraint(equalTo: addressStackView.topAnchor),
            schoolNumberStackView.leftAnchor.constraint(equalTo: addressStackView.leftAnchor),
            schoolNumberStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.25),
            schoolNumberStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.7),
            
            findLabel.topAnchor.constraint(equalTo: schoolNumberStackView.topAnchor),
            findLabel.leftAnchor.constraint(equalTo: schoolNumberStackView.leftAnchor),
            findLabel.heightAnchor.constraint(equalTo: schoolNumberStackView.heightAnchor),
            findLabel.widthAnchor.constraint(equalTo: schoolNumberStackView.widthAnchor, multiplier: 0.25),
            
            nearestLabel.topAnchor.constraint(equalTo: schoolNumberStackView.topAnchor),
            nearestLabel.rightAnchor.constraint(equalTo: schoolNumberStackView.rightAnchor),
            nearestLabel.heightAnchor.constraint(equalTo: schoolNumberStackView.heightAnchor),
            nearestLabel.widthAnchor.constraint(equalTo: schoolNumberStackView.widthAnchor, multiplier: 0.3),
            
            addressStackView.bottomAnchor.constraint(equalTo: errorLabel.topAnchor),
            addressStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.4),
            addressStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor),
            addressStackView.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: addressStackView.topAnchor),
            addressLabel.leftAnchor.constraint(equalTo: addressStackView.leftAnchor),
            addressLabel.heightAnchor.constraint(equalTo: addressStackView.heightAnchor),
            addressLabel.widthAnchor.constraint(equalTo: addressStackView.widthAnchor, multiplier: 0.2),
            
            errorLabel.bottomAnchor.constraint(equalTo: headerStackView.bottomAnchor),
            errorLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.15),
            errorLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.6),
            errorLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
        ])
    }
}

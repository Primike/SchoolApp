//
//  NearbySchoolsHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class AddressSearchHeaderView: UIView {
    
    let headerStackView = UIStackView()
    let addressHeaderLabel = UILabel()
    let schoolNumberStackView = UIStackView()
    let findLabel = UILabel()
    let nearestLabel = UILabel()
    let addressStackView = UIStackView()
    let addressLabel = UILabel()
    let errorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
    
    func setup() {
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addressStackView.translatesAutoresizingMaskIntoConstraints = false
        addressStackView.axis = .vertical
        
        addressHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        addressHeaderLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        addressHeaderLabel.adjustsFontSizeToFitWidth = true
        addressHeaderLabel.textAlignment = .center
        addressHeaderLabel.text = "Search Nearby Schools By Address"
        addressHeaderLabel.textColor = .white
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        addressLabel.adjustsFontSizeToFitWidth = true
        addressLabel.textAlignment = .center
        addressLabel.text = "Address:"
        addressLabel.textColor = .white
        
        schoolNumberStackView.translatesAutoresizingMaskIntoConstraints = false
        
        findLabel.translatesAutoresizingMaskIntoConstraints = false
        findLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        findLabel.adjustsFontSizeToFitWidth = true
        findLabel.textAlignment = .center
        findLabel.text = "Find"
        findLabel.textColor = .white
        
        nearestLabel.translatesAutoresizingMaskIntoConstraints = false
        nearestLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        nearestLabel.adjustsFontSizeToFitWidth = true
        nearestLabel.textAlignment = .center
        nearestLabel.text = "Nearest Schools"
        nearestLabel.textColor = .white
        nearestLabel.numberOfLines = 0
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont(name:"HelveticaNeue-bold", size: 100.0)
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textColor = .systemRed
        errorLabel.text = "Error Label"
        errorLabel.isHidden = true
    }
    
    func layout() {
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

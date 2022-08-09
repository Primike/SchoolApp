//
//  NearbySchoolsHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/21/22.
//

import Foundation
import UIKit

class AddressSearchHeaderView: UIView {
    
    let addressHeaderLabel = UILabel()
    let addressStackView = UIStackView()
    let addressLabel = UILabel()
    let schoolNumberStackView = UIStackView()
    let findLabel = UILabel()
    let nearestLabel = UILabel()
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
        addressStackView.translatesAutoresizingMaskIntoConstraints = false
        addressStackView.axis = .vertical
        
        addressHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        addressHeaderLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        addressHeaderLabel.adjustsFontSizeToFitWidth = true
        addressHeaderLabel.textAlignment = .center
        addressHeaderLabel.text = "Search Nearby Schools By Address"
        addressHeaderLabel.textColor = .white
        addressHeaderLabel.numberOfLines = 0
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        addressLabel.adjustsFontSizeToFitWidth = true
        addressLabel.textAlignment = .center
        addressLabel.text = "Address:"
        addressLabel.textColor = .white
        addressLabel.numberOfLines = 0
        
        schoolNumberStackView.translatesAutoresizingMaskIntoConstraints = false
        
        findLabel.translatesAutoresizingMaskIntoConstraints = false
        findLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        findLabel.adjustsFontSizeToFitWidth = true
        findLabel.textAlignment = .center
        findLabel.text = "Find"
        findLabel.textColor = .white
        findLabel.numberOfLines = 0
        
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
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .systemRed
        errorLabel.text = "Error Label"
        errorLabel.isHidden = true
    }
    
    func layout() {
        self.addSubview(addressHeaderLabel)
        self.addSubview(addressStackView)
        self.addSubview(schoolNumberStackView)
        
        addressStackView.addSubview(addressLabel)
        addressStackView.addSubview(errorLabel)
        
        schoolNumberStackView.addSubview(findLabel)
        schoolNumberStackView.addSubview(nearestLabel)

        NSLayoutConstraint.activate([
            addressHeaderLabel.topAnchor.constraint(equalTo: self.topAnchor),
            addressHeaderLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            addressHeaderLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            addressHeaderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            addressStackView.topAnchor.constraint(equalTo: addressHeaderLabel.bottomAnchor),
            addressStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            addressStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            addressStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: addressStackView.topAnchor),
            addressLabel.leftAnchor.constraint(equalTo: addressStackView.leftAnchor),
            addressLabel.heightAnchor.constraint(equalTo: addressStackView.heightAnchor),
            addressLabel.widthAnchor.constraint(equalTo: addressStackView.widthAnchor, multiplier: 0.2),
            
            //maybe put inside another stack view
            schoolNumberStackView.topAnchor.constraint(equalTo: addressStackView.bottomAnchor),
            schoolNumberStackView.leftAnchor.constraint(equalTo: addressStackView.leftAnchor),
            schoolNumberStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            schoolNumberStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            
            findLabel.topAnchor.constraint(equalTo: schoolNumberStackView.topAnchor),
            findLabel.leftAnchor.constraint(equalTo: schoolNumberStackView.leftAnchor),
            findLabel.heightAnchor.constraint(equalTo: schoolNumberStackView.heightAnchor),
            findLabel.widthAnchor.constraint(equalTo: schoolNumberStackView.widthAnchor, multiplier: 0.3),
            
            nearestLabel.topAnchor.constraint(equalTo: schoolNumberStackView.topAnchor),
            nearestLabel.rightAnchor.constraint(equalTo: schoolNumberStackView.rightAnchor),
            nearestLabel.heightAnchor.constraint(equalTo: schoolNumberStackView.heightAnchor),
            nearestLabel.widthAnchor.constraint(equalTo: schoolNumberStackView.widthAnchor, multiplier: 0.3),
            
            errorLabel.topAnchor.constraint(equalTo: schoolNumberStackView.bottomAnchor),
            errorLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            errorLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

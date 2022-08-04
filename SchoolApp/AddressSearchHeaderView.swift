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
        
        addressStackView.addSubview(addressLabel)
        addressStackView.addSubview(errorLabel)

        NSLayoutConstraint.activate([
            addressHeaderLabel.topAnchor.constraint(equalTo: self.topAnchor),
            addressHeaderLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            addressHeaderLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            addressHeaderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            addressStackView.topAnchor.constraint(equalTo: addressHeaderLabel.bottomAnchor),
            addressStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            addressStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            addressStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: addressStackView.topAnchor),
            addressLabel.leftAnchor.constraint(equalTo: addressStackView.leftAnchor),
            addressLabel.heightAnchor.constraint(equalTo: addressStackView.heightAnchor),
            addressLabel.widthAnchor.constraint(equalTo: addressStackView.widthAnchor, multiplier: 0.2),
            
            errorLabel.topAnchor.constraint(equalTo: addressStackView.bottomAnchor),
            errorLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            errorLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

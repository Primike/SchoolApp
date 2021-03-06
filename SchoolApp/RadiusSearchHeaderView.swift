//
//  RadiusSearchView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/24/22.
//

import Foundation
import UIKit

class RadiusSearchHeaderView: UIView {
    
    let headerStackView = UIStackView()
    let headerLabel = UILabel()
    let withinLabel = UILabel()
    let milesLabel = UILabel()
    let errorLabel = UILabel()
    let middleStackView = UIStackView()
    let inputStackView = UIStackView()
    let buttonStackView = UIStackView()
    
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
        headerStackView.axis = .vertical
        
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.axis = .horizontal
        
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        inputStackView.axis = .horizontal
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        headerLabel.adjustsFontSizeToFitWidth = true
        headerLabel.textAlignment = .center
        headerLabel.text = "Search Nearby Schools By Miles"
        headerLabel.textColor = .white
        headerLabel.numberOfLines = 0
        
        withinLabel.translatesAutoresizingMaskIntoConstraints = false
        withinLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        withinLabel.adjustsFontSizeToFitWidth = true
        withinLabel.textAlignment = .center
        withinLabel.text = "Within"
        withinLabel.textColor = .white
        withinLabel.numberOfLines = 0
        
        milesLabel.translatesAutoresizingMaskIntoConstraints = false
        milesLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        milesLabel.adjustsFontSizeToFitWidth = true
        milesLabel.textAlignment = .center
        milesLabel.text = "Miles"
        milesLabel.textColor = .white
        milesLabel.numberOfLines = 0
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont(name:"HelveticaNeue-bold", size: 100.0)
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .systemRed
        errorLabel.isHidden = true
    }
    
    func layout() {
        self.addSubview(headerStackView)
        headerStackView.addSubview(headerLabel)
        headerStackView.addSubview(middleStackView)
        headerStackView.addSubview(errorLabel)
        
        middleStackView.addSubview(inputStackView)
        middleStackView.addSubview(buttonStackView)
        
        inputStackView.addSubview(withinLabel)
        inputStackView.addSubview(milesLabel)
        
        NSLayoutConstraint.activate([
            headerStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            headerStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            headerLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.2),
            headerLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.9),
            headerLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            middleStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            middleStackView.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.5),
            middleStackView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.9),
            middleStackView.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
            
            inputStackView.topAnchor.constraint(equalTo: middleStackView.topAnchor),
            inputStackView.leftAnchor.constraint(equalTo: middleStackView.leftAnchor),
            inputStackView.heightAnchor.constraint(equalTo: middleStackView.heightAnchor),
            inputStackView.widthAnchor.constraint(equalTo: middleStackView.widthAnchor, multiplier: 0.7),
            
            withinLabel.topAnchor.constraint(equalTo: inputStackView.topAnchor),
            withinLabel.leftAnchor.constraint(equalTo: inputStackView.leftAnchor),
            withinLabel.heightAnchor.constraint(equalTo: inputStackView.heightAnchor),
            withinLabel.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.3),
            
            milesLabel.topAnchor.constraint(equalTo: inputStackView.topAnchor),
            milesLabel.rightAnchor.constraint(equalTo: inputStackView.rightAnchor),
            milesLabel.heightAnchor.constraint(equalTo: inputStackView.heightAnchor),
            milesLabel.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.3),
            
            buttonStackView.topAnchor.constraint(equalTo: middleStackView.topAnchor),
            buttonStackView.rightAnchor.constraint(equalTo: middleStackView.rightAnchor),
            buttonStackView.heightAnchor.constraint(equalTo: middleStackView.heightAnchor),
            buttonStackView.widthAnchor.constraint(equalTo: middleStackView.widthAnchor, multiplier: 0.25),
            
            errorLabel.topAnchor.constraint(equalTo: middleStackView.bottomAnchor),
            errorLabel.heightAnchor.constraint(equalTo: headerStackView.heightAnchor, multiplier: 0.3),
            errorLabel.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.9),
            errorLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor),
        ])
    }
}

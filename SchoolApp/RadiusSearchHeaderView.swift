//
//  RadiusSearchView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/24/22.
//

import Foundation
import UIKit

class RadiusSearchHeaderView: UIView {
    
    lazy var headerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "Search Nearby Schools"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var middleStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    lazy var inputStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    lazy var withinLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "Within"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    lazy var milesLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "Miles"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    lazy var errorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-bold", size: 100.0)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = .systemRed
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

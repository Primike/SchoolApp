//
//  YAxisView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class YAxisView: UIView {
    
    let label800 = UILabel()
    let stackView600 = UIStackView()
    let label600 = UILabel()
    let stackView400 = UIStackView()
    let label400 = UILabel()
    let stackView200 = UIStackView()
    let label200 = UILabel()
    let label0 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        label800.translatesAutoresizingMaskIntoConstraints = false
        label800.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label800.text = "800 -"
        label800.textAlignment = .center
        label800.adjustsFontSizeToFitWidth = true
        label800.textColor = .black
        
        stackView600.translatesAutoresizingMaskIntoConstraints = false
        
        label600.translatesAutoresizingMaskIntoConstraints = false
        label600.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label600.text = "600 -"
        label600.textAlignment = .center
        label600.adjustsFontSizeToFitWidth = true
        label600.textColor = .black
        
        stackView400.translatesAutoresizingMaskIntoConstraints = false
        
        label400.translatesAutoresizingMaskIntoConstraints = false
        label400.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label400.text = "400 -"
        label400.textAlignment = .center
        label400.adjustsFontSizeToFitWidth = true
        label400.textColor = .black

        stackView200.translatesAutoresizingMaskIntoConstraints = false
        
        label200.translatesAutoresizingMaskIntoConstraints = false
        label200.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label200.text = "200 -"
        label200.textAlignment = .center
        label200.adjustsFontSizeToFitWidth = true
        label200.textColor = .black

        label0.translatesAutoresizingMaskIntoConstraints = false
        label0.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label0.text = "0 -"
        label0.textAlignment = .center
        label0.adjustsFontSizeToFitWidth = true
        label0.textColor = .black
    }
    
    func layout() {
        self.addSubview(label800)
        self.addSubview(stackView600)
        self.addSubview(stackView400)
        self.addSubview(stackView200)
        self.addSubview(label0)
        
        stackView600.addSubview(label600)
        stackView400.addSubview(label400)
        stackView200.addSubview(label200)
        
        NSLayoutConstraint.activate([
            label800.topAnchor.constraint(equalTo: self.topAnchor),
            label800.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            label800.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            stackView600.topAnchor.constraint(equalTo: label800.bottomAnchor),
            stackView600.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            stackView600.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            label600.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            label600.widthAnchor.constraint(equalTo: self.widthAnchor),
            label600.centerYAnchor.constraint(equalTo: stackView600.centerYAnchor),
            
            stackView400.topAnchor.constraint(equalTo: stackView600.bottomAnchor),
            stackView400.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            stackView400.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            label400.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            label400.widthAnchor.constraint(equalTo: self.widthAnchor),
            label400.centerYAnchor.constraint(equalTo: stackView400.centerYAnchor),
            
            stackView200.bottomAnchor.constraint(equalTo: label0.topAnchor),
            stackView200.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            stackView200.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            label200.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            label200.widthAnchor.constraint(equalTo: self.widthAnchor),
            label200.centerYAnchor.constraint(equalTo: stackView200.centerYAnchor),
            
            label0.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            label0.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
}


//label800.topAnchor.constraint(equalTo: self.topAnchor),
//label800.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
//label800.widthAnchor.constraint(equalTo: self.widthAnchor),
//
//stackView600.topAnchor.constraint(equalTo: label800.bottomAnchor),
//stackView600.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
//stackView600.widthAnchor.constraint(equalTo: self.widthAnchor),
//
//stackView400.topAnchor.constraint(equalTo: stackView600.bottomAnchor),
//stackView400.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
//stackView400.widthAnchor.constraint(equalTo: self.widthAnchor),
//
//stackView200.bottomAnchor.constraint(equalTo: label0.topAnchor),
//stackView200.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
//stackView200.widthAnchor.constraint(equalTo: self.widthAnchor),
//
//label600.topAnchor.constraint(equalTo: label800.bottomAnchor),
//label600.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
//label600.widthAnchor.constraint(equalTo: self.widthAnchor),
//
//label400.topAnchor.constraint(equalTo: label600.bottomAnchor),
//label400.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
//label400.widthAnchor.constraint(equalTo: self.widthAnchor),
//
//label200.bottomAnchor.constraint(equalTo: label0.topAnchor),
//label200.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
//label200.widthAnchor.constraint(equalTo: self.widthAnchor),
//
//label0.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//label0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
//label0.widthAnchor.constraint(equalTo: self.widthAnchor),

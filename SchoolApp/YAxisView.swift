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
    let label600 = UILabel()
    let label400 = UILabel()
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
        label800.text = "800 - "
        label800.textAlignment = .center
        label800.adjustsFontSizeToFitWidth = true
        label800.textColor = .black
        
        label600.translatesAutoresizingMaskIntoConstraints = false
        label600.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label600.text = "600 - "
        label600.textAlignment = .center
        label600.adjustsFontSizeToFitWidth = true
        label600.textColor = .black
        
        label400.translatesAutoresizingMaskIntoConstraints = false
        label400.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label400.text = "400 - "
        label400.textAlignment = .center
        label400.adjustsFontSizeToFitWidth = true
        label400.textColor = .black

        label200.translatesAutoresizingMaskIntoConstraints = false
        label200.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label200.text = "200 - "
        label200.textAlignment = .center
        label200.adjustsFontSizeToFitWidth = true
        label200.textColor = .black

        label0.translatesAutoresizingMaskIntoConstraints = false
        label0.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        label0.text = "0 - "
        label0.textAlignment = .center
        label0.adjustsFontSizeToFitWidth = true
        label0.textColor = .black
    }
    
    func layout() {
        self.addSubview(label800)
        self.addSubview(label600)
        self.addSubview(label400)
        self.addSubview(label200)
        self.addSubview(label0)
        
        NSLayoutConstraint.activate([
            label800.topAnchor.constraint(equalTo: self.topAnchor),
            label800.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            label800.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            label600.topAnchor.constraint(equalTo: label800.bottomAnchor),
            label600.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            label600.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            label400.topAnchor.constraint(equalTo: label600.bottomAnchor),
            label400.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            label400.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            label200.bottomAnchor.constraint(equalTo: label0.topAnchor),
            label200.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            label200.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            label0.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            label0.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
}

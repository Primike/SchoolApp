//
//  YAxisView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class YAxisView: UIView {
    
    lazy var label800: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "800 -", labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        return label
    }()

    lazy var stackView600: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var label600: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "600 -", labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        return label
    }()

    lazy var stackView400: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var label400: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "400 -", labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        return label
    }()

    lazy var stackView200: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var label200: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "200 -", labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        return label
    }()

    lazy var label0: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "0 -", labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Italics", size: 15.0)
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

//
//  YAxisView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class YAxisView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var label800: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "800 -", fontSize: .largeTitle)
        return label
    }()

    lazy var label600: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "600 -", fontSize: .largeTitle)
        return label
    }()

    lazy var label400: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "400 -", fontSize: .largeTitle)
        return label
    }()

    lazy var label200: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "200 -", fontSize: .largeTitle)
        return label
    }()

    lazy var label0: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "0 -", fontSize: .largeTitle)
        return label
    }()
        
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        stackView.addArrangedSubview(label800)
        stackView.addArrangedSubview(label600)
        stackView.addArrangedSubview(label400)
        stackView.addArrangedSubview(label200)
        stackView.addArrangedSubview(label0)
                
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            label800.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.05),
            label600.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.05),
            label400.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.05),
            label200.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.05),
            label0.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.05),
        ])
    }
}

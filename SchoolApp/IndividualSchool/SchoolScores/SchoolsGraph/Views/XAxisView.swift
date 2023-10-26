//
//  XAxisView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class XAxisView: UIView {
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .horizontal)
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var mathLabel: SchoolAppLabel = {
        let label = SchoolAppLabel(labelText: "SAT MATH", fontSize: .largeTitle)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var writingLabel: SchoolAppLabel = {
        let label = SchoolAppLabel(labelText: "SAT WRITING", fontSize: .largeTitle)
        label.numberOfLines = 2
        return label
    }()

    lazy var readingLabel: SchoolAppLabel = {
        let label = SchoolAppLabel(labelText: "SAT CRITICAL READING", fontSize: .largeTitle)
        label.numberOfLines = 2
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(mathLabel)
        self.addSubview(writingLabel)
        self.addSubview(readingLabel)
        
        NSLayoutConstraint.activate([
            mathLabel.topAnchor.constraint(equalTo: self.topAnchor),
            mathLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            mathLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            mathLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),

            writingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            writingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            writingLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            writingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),

            readingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            readingLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            readingLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            readingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
        ])
    }
}

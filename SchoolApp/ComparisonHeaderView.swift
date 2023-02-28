//
//  CompareHeaderView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/11/22.
//

import Foundation
import UIKit

class ComparisonHeaderView: UIView {
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var mySchoolsLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Select Two Schools To Compare Details", labelTextColor: .white)
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
    
    func layout() {
        self.addSubview(stackView)
        
//        stackView.addSubview(heartImage)
        stackView.addSubview(mySchoolsLabel)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            mySchoolsLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.9),
            mySchoolsLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8),
            mySchoolsLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            mySchoolsLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        ])
    }
}

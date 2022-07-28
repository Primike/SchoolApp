//
//  MySchoolsEmptyView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/28/22.
//

import Foundation
import UIKit

class MySchoolsHeaderView: UIView {
    
    let mySchoolsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
    
    func setup() {
        self.backgroundColor = .systemBlue
        
        mySchoolsLabel.translatesAutoresizingMaskIntoConstraints = false
        mySchoolsLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0 )
        mySchoolsLabel.adjustsFontSizeToFitWidth = true
        mySchoolsLabel.textAlignment = .center
        mySchoolsLabel.text = "Add Schools And They Will Appear Here!"
        mySchoolsLabel.textColor = .white
        mySchoolsLabel.numberOfLines = 0
    }
    
    func layout() {
        self.addSubview(mySchoolsLabel)
        
        NSLayoutConstraint.activate([
            mySchoolsLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            mySchoolsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            mySchoolsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mySchoolsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}

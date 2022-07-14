//
//  SchoolInfoBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolInfoBottomView: UIView {
    let aboutLabel = UILabel()
    let schoolDescription = UILabel()
    
    let school: School
    let schoolColor: UIColor
    
    init(frame: CGRect, school: School, schoolColor: UIColor) {
        self.school = school
        self.schoolColor = schoolColor
        
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.font = UIFont(name:"HelveticaNeue-Bold", size:100.0)
        aboutLabel.text = "About:"
        aboutLabel.adjustsFontSizeToFitWidth = true
        aboutLabel.textAlignment = .center
        aboutLabel.textColor = .white
        aboutLabel.baselineAdjustment = .alignCenters
        
        schoolDescription.translatesAutoresizingMaskIntoConstraints = false
        schoolDescription.font = UIFont(name:"HelveticaNeue", size: 100.0)
        schoolDescription.adjustsFontSizeToFitWidth = true
        schoolDescription.text = school.overview_paragraph
        schoolDescription.numberOfLines = 0
        schoolDescription.textAlignment = .left
        schoolDescription.textColor = .white
    }
    
    func layout() {
        self.addSubview(aboutLabel)
        self.addSubview(schoolDescription)
        
        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            aboutLabel.leftAnchor.constraint(equalTo: schoolDescription.leftAnchor),
            aboutLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            aboutLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            schoolDescription.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor),
            schoolDescription.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            schoolDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            schoolDescription.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75)
        ])
    }
}

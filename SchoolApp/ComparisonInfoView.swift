//
//  SchoolInfoView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class ComparisonInfoView: UIView {
    
    let schoolInfoStackView = UIStackView()
    let schoolName = UILabel()
    let schoolLocation = UILabel()
    let schoolPhone = UILabel()
    
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
        schoolInfoStackView.translatesAutoresizingMaskIntoConstraints = false

        schoolName.translatesAutoresizingMaskIntoConstraints = false
        schoolName.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        schoolName.adjustsFontSizeToFitWidth = true
        schoolName.text = school.school_name
        schoolName.numberOfLines = 2
        schoolName.textAlignment = .center
        
        schoolLocation.translatesAutoresizingMaskIntoConstraints = false
        schoolLocation.font = UIFont(name:"HelveticaNeue", size: 100.0)
        schoolLocation.adjustsFontSizeToFitWidth = true
        schoolLocation.text = school.location
        schoolLocation.textAlignment = .center
        
        schoolPhone.translatesAutoresizingMaskIntoConstraints = false
        schoolPhone.adjustsFontSizeToFitWidth = true
        schoolPhone.font = UIFont(name:"HelveticaNeue", size: 100.0)
        schoolPhone.text = "Phone: \(school.phone_number)"
        schoolPhone.textAlignment = .center
    }
    
    func layout() {
        self.addSubview(schoolInfoStackView)
        
        schoolInfoStackView.addSubview(schoolName)
        schoolInfoStackView.addSubview(schoolLocation)
        schoolInfoStackView.addSubview(schoolPhone)
        
        NSLayoutConstraint.activate([
            schoolInfoStackView.topAnchor.constraint(equalTo: self.topAnchor),
            schoolInfoStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            schoolInfoStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            schoolInfoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            schoolName.topAnchor.constraint(equalTo: schoolInfoStackView.topAnchor),
            schoolName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            schoolName.widthAnchor.constraint(equalTo: self.widthAnchor),
            schoolName.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            
            schoolLocation.topAnchor.constraint(equalTo: schoolName.bottomAnchor),
            schoolLocation.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            schoolLocation.widthAnchor.constraint(equalTo: self.widthAnchor),
            schoolLocation.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            
            schoolPhone.topAnchor.constraint(equalTo: schoolLocation.bottomAnchor),
            schoolPhone.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            schoolPhone.widthAnchor.constraint(equalTo: self.widthAnchor),
            schoolPhone.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
        ])
    }
}

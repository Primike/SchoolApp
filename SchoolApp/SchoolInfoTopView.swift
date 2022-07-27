//
//  SchoolInfoTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolInfoTopView: UIView {
    
    let topButtonsStackView = UIStackView()
    let schoolInfoStackView = UIStackView()
    let schoolName = UILabel()
    let schoolLocation = UILabel()
    let schoolPhone = UILabel()
    let schoolImage = UIImageView(image: UIImage(systemName: "book.circle"))
    
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
        topButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        topButtonsStackView.axis = .horizontal
        
        schoolInfoStackView.translatesAutoresizingMaskIntoConstraints = false

        schoolName.translatesAutoresizingMaskIntoConstraints = false
        schoolName.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        schoolName.adjustsFontSizeToFitWidth = true
        schoolName.text = school.school_name
        schoolName.numberOfLines = 2
        schoolName.textAlignment = .left
        
        schoolLocation.translatesAutoresizingMaskIntoConstraints = false
        schoolLocation.font = UIFont(name:"HelveticaNeue", size: 100.0)
        schoolLocation.adjustsFontSizeToFitWidth = true
        schoolLocation.text = school.location
        schoolLocation.textAlignment = .left
        
        schoolPhone.translatesAutoresizingMaskIntoConstraints = false
        schoolPhone.adjustsFontSizeToFitWidth = true
        schoolPhone.font = UIFont(name:"HelveticaNeue", size: 100.0)
        schoolPhone.text = "Phone: \(school.phone_number)"
        schoolPhone.textAlignment = .left

        schoolImage.translatesAutoresizingMaskIntoConstraints = false
        schoolImage.contentMode = .scaleAspectFit
        schoolImage.tintColor = schoolColor
    }
    
    func layout() {
        self.addSubview(topButtonsStackView)
        self.addSubview(schoolName)
        self.addSubview(schoolLocation)
        self.addSubview(schoolPhone)
        self.addSubview(schoolImage)
        
        NSLayoutConstraint.activate([
            topButtonsStackView.topAnchor.constraint(equalTo: self.topAnchor),
            topButtonsStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            topButtonsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            topButtonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            schoolName.topAnchor.constraint(equalTo: topButtonsStackView.bottomAnchor),
            schoolName.leftAnchor.constraint(equalTo: topButtonsStackView.leftAnchor),
            schoolName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            schoolName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
            schoolLocation.topAnchor.constraint(equalTo: schoolName.bottomAnchor),
            schoolLocation.leftAnchor.constraint(equalTo: topButtonsStackView.leftAnchor),
            schoolLocation.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            schoolLocation.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
            schoolPhone.topAnchor.constraint(equalTo: schoolLocation.bottomAnchor),
            schoolPhone.leftAnchor.constraint(equalTo: topButtonsStackView.leftAnchor),
            schoolPhone.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            schoolPhone.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            
            schoolImage.topAnchor.constraint(equalTo: schoolPhone.bottomAnchor),
            schoolImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            schoolImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
        ])
    }
}

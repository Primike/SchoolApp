//
//  SchoolInfoTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolInfoTopView: UIView {
    
    lazy var topButtonsStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var schoolInfoStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var schoolName: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: school.school_name, labelTextColor: schoolColor)
        label.textAlignment = .left
        return label
    }()

    lazy var schoolLocation: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: school.location, labelTextColor: .black)
        label.textAlignment = .left
        return label
    }()

    lazy var schoolPhone: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Phone: \(school.phone_number)", labelTextColor: .black)
        label.textAlignment = .left
        return label
    }()

    lazy var schoolImage: UIImageView = {
        var image = UIImageView(image: UIImage(systemName: "book.circle"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = schoolColor
        return image
    }()
    
    let school: School
    let schoolColor: UIColor
    
    init(frame: CGRect, school: School, schoolColor: UIColor) {
        self.school = school
        self.schoolColor = schoolColor
        
        super.init(frame: frame)

        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

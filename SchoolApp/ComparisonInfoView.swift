//
//  SchoolInfoView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class ComparisonInfoView: UIView {
    
    lazy var schoolInfoStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var schoolName: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: school.school_name, labelTextColor: color)
        return label
    }()
    
    
    lazy var schoolLocation: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: school.location, labelTextColor: color)
        return label
    }()
    
    lazy var schoolPhone: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Phone: \(school.phone_number)", labelTextColor: color)
        return label
    }()
    
    lazy var distanceLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Distance: Not Available", labelTextColor: color)
        return label
    }()
    
    lazy var testtakersLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Test Takers: Not Available", labelTextColor: color)
        return label
    }()
    
    lazy var mathLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Math Score: Not Available", labelTextColor: color)
        return label
    }()

    lazy var writingLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Writing Score: Not Available", labelTextColor: color)
        return label
    }()
    
    lazy var readingLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "Reading Score: Not Available", labelTextColor: color)
        return label
    }()
    
    let school: School
    let color: UIColor
    
    init(frame: CGRect, school: School, color: UIColor) {
        self.school = school
        self.color = color
        
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(schoolInfoStackView)
        
        schoolInfoStackView.addSubview(schoolName)
        schoolInfoStackView.addSubview(schoolLocation)
        schoolInfoStackView.addSubview(schoolPhone)
        schoolInfoStackView.addSubview(distanceLabel)
        schoolInfoStackView.addSubview(testtakersLabel)
        schoolInfoStackView.addSubview(mathLabel)
        schoolInfoStackView.addSubview(writingLabel)
        schoolInfoStackView.addSubview(readingLabel)
        
        NSLayoutConstraint.activate([
            schoolInfoStackView.topAnchor.constraint(equalTo: self.topAnchor),
            schoolInfoStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            schoolInfoStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            schoolInfoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            schoolName.topAnchor.constraint(equalTo: schoolInfoStackView.topAnchor),
            schoolName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            schoolName.widthAnchor.constraint(equalTo: self.widthAnchor),
            schoolName.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            
            schoolLocation.topAnchor.constraint(equalTo: schoolName.bottomAnchor),
            schoolLocation.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            schoolLocation.widthAnchor.constraint(equalTo: self.widthAnchor),
            schoolLocation.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            
            schoolPhone.topAnchor.constraint(equalTo: schoolLocation.bottomAnchor),
            schoolPhone.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            schoolPhone.widthAnchor.constraint(equalTo: self.widthAnchor),
            schoolPhone.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            
            distanceLabel.topAnchor.constraint(equalTo: schoolPhone.bottomAnchor),
            distanceLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            distanceLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            distanceLabel.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            
            testtakersLabel.bottomAnchor.constraint(equalTo: mathLabel.topAnchor),
            testtakersLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            testtakersLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            testtakersLabel.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            
            mathLabel.bottomAnchor.constraint(equalTo: writingLabel.topAnchor),
            mathLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            mathLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            mathLabel.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            
            writingLabel.bottomAnchor.constraint(equalTo: readingLabel.topAnchor),
            writingLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            writingLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            writingLabel.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
            
            readingLabel.bottomAnchor.constraint(equalTo: schoolInfoStackView.bottomAnchor),
            readingLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            readingLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            readingLabel.centerXAnchor.constraint(equalTo: schoolInfoStackView.centerXAnchor),
        ])
    }
}

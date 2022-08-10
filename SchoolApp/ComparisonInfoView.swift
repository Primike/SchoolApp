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
    let distanceLabel = UILabel()
    let testtakersLabel = UILabel()
    let mathLabel = UILabel()
    let writingLabel = UILabel()
    let readingLabel = UILabel()
    
    let school: School
    let color: UIColor
    
    init(frame: CGRect, school: School, color: UIColor) {
        self.school = school
        self.color = color
        
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
        schoolName.textAlignment = .left
        schoolName.textColor = color
        
        schoolLocation.translatesAutoresizingMaskIntoConstraints = false
        schoolLocation.font = UIFont(name:"HelveticaNeue", size: 100.0)
        schoolLocation.adjustsFontSizeToFitWidth = true
        schoolLocation.text = school.location
        schoolLocation.textAlignment = .left
        schoolLocation.numberOfLines = 2
        schoolLocation.textColor = color
        
        schoolPhone.translatesAutoresizingMaskIntoConstraints = false
        schoolPhone.adjustsFontSizeToFitWidth = true
        schoolPhone.font = UIFont(name:"HelveticaNeue", size: 100.0)
        schoolPhone.text = "Phone: \(school.phone_number)"
        schoolPhone.textAlignment = .left
        schoolPhone.textColor = color
        
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.adjustsFontSizeToFitWidth = true
        distanceLabel.font = UIFont(name:"HelveticaNeue", size: 100.0)
        distanceLabel.text = "Distance: Not Available"
        distanceLabel.textAlignment = .left
        distanceLabel.textColor = color
        
        testtakersLabel.translatesAutoresizingMaskIntoConstraints = false
        testtakersLabel.adjustsFontSizeToFitWidth = true
        testtakersLabel.font = UIFont(name:"HelveticaNeue", size: 100.0)
        testtakersLabel.text = "Test Takers: Not Available"
        testtakersLabel.textAlignment = .left
        testtakersLabel.textColor = color
        
        mathLabel.translatesAutoresizingMaskIntoConstraints = false
        mathLabel.adjustsFontSizeToFitWidth = true
        mathLabel.font = UIFont(name:"HelveticaNeue", size: 100.0)
        mathLabel.text = "Math Score: Not Available"
        mathLabel.textAlignment = .left
        mathLabel.textColor = color
        
        writingLabel.translatesAutoresizingMaskIntoConstraints = false
        writingLabel.adjustsFontSizeToFitWidth = true
        writingLabel.font = UIFont(name:"HelveticaNeue", size: 100.0)
        writingLabel.text = "Writing Score: Not Available"
        writingLabel.textAlignment = .left
        writingLabel.textColor = color
        
        readingLabel.translatesAutoresizingMaskIntoConstraints = false
        readingLabel.adjustsFontSizeToFitWidth = true
        readingLabel.font = UIFont(name:"HelveticaNeue", size: 100.0)
        readingLabel.text = "Reading Score: Not Available"
        readingLabel.textAlignment = .left
        readingLabel.textColor = color
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

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

    lazy var schoolName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = color
        label.text = school.school_name
        return label
    }()
    
    
    lazy var schoolLocation: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue", size: 100.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = color
        label.text = school.location
        return label
    }()
    
    lazy var schoolPhone: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name:"HelveticaNeue", size: 100.0)
        label.textAlignment = .left
        label.textColor = color
        label.text = "Phone: \(school.phone_number)"
        return label
    }()
    
    lazy var distanceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name:"HelveticaNeue", size: 100.0)
        label.text = "Distance: Not Available"
        label.textAlignment = .left
        label.textColor = color
        return label
    }()
    
    lazy var testtakersLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name:"HelveticaNeue", size: 100.0)
        label.text = "Test Takers: Not Available"
        label.textAlignment = .left
        label.textColor = color
        return label
    }()
    
    lazy var mathLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name:"HelveticaNeue", size: 100.0)
        label.text = "Math Score: Not Available"
        label.textAlignment = .left
        label.textColor = color
        return label
    }()

    lazy var writingLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name:"HelveticaNeue", size: 100.0)
        label.text = "Writing Score: Not Available"
        label.textAlignment = .left
        label.textColor = color
        return label
    }()
    
    lazy var readingLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name:"HelveticaNeue", size: 100.0)
        label.text = "Reading Score: Not Available"
        label.textAlignment = .left
        label.textColor = color
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

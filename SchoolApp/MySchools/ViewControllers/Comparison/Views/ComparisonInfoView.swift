//
//  SchoolInfoView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class ComparisonInfoView: UIView {
    
    let schoolData: SchoolData
    let color: UIColor
    
    init(schoolData: SchoolData, color: UIColor) {
        self.schoolData = schoolData
        self.color = color
        
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        stackView.distribution = .equalSpacing
        return stackView
    }()

    lazy var schoolName: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: schoolData.school.school_name, fontSize: .largeTitle)
        label.textColor = color
        label.numberOfLines = 2
        return label
    }()
    
    lazy var schoolLocation: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: schoolData.school.location, fontSize: .title3)
        label.textColor = color
        label.numberOfLines = 2
        return label
    }()
    
    lazy var schoolPhone: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Phone: \(schoolData.school.phone_number)", fontSize: .title3)
        label.textColor = color
        return label
    }()
    
    lazy var distanceLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Distance: Not Available", fontSize: .title3)
        label.textColor = color
        return label
    }()
    
    lazy var testtakersLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Test Takers: Not Available", fontSize: .title3)
        label.textColor = color
        return label
    }()
    
    lazy var mathLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Math Score: Not Available", fontSize: .title3)
        label.textColor = color
        return label
    }()

    lazy var writingLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Writing Score: Not Available", fontSize: .title3)
        label.textColor = color
        return label
    }()
    
    lazy var readingLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Reading Score: Not Available", fontSize: .title3)
        label.textColor = color
        return label
    }()
        
    func layout() {
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(schoolName)
        stackView.addArrangedSubview(schoolLocation)
        stackView.addArrangedSubview(schoolPhone)
        stackView.addArrangedSubview(distanceLabel)
        stackView.addArrangedSubview(testtakersLabel)
        stackView.addArrangedSubview(mathLabel)
        stackView.addArrangedSubview(writingLabel)
        stackView.addArrangedSubview(readingLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

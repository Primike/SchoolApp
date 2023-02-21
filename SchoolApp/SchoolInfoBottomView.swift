//
//  SchoolInfoBottomView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class SchoolInfoBottomView: UIView {
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var aboutLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: "About:", labelTextColor: .white)
        label.textAlignment = .left
        return label
    }()

    lazy var schoolDescription: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: school.overview_paragraph, labelTextColor: .white)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
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
        self.addSubview(stackView)
        stackView.addSubview(aboutLabel)
        stackView.addSubview(schoolDescription)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            aboutLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            aboutLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            aboutLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.15),
            aboutLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.25),
            
            schoolDescription.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor),
            schoolDescription.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            schoolDescription.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.80),
            schoolDescription.widthAnchor.constraint(equalTo: stackView.widthAnchor),
        ])
    }
}

//
//  BottomSubjectView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/4/22.
//

import Foundation
import UIKit

class BottomSubjectView: UIView {
    
    let satSubjectStackView = UIStackView()
    let satSubjectLabel = UILabel()
    let satSubjectScore = UILabel()
    
    let schoolColor: UIColor
    let subjectName: String
    let subjectScore: String
    
    init(frame: CGRect, schoolColor: UIColor, subjectName: String, subjectScore: String) {
        self.schoolColor = schoolColor
        self.subjectName = subjectName
        self.subjectScore = subjectScore
        
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        satSubjectStackView.translatesAutoresizingMaskIntoConstraints = false
        satSubjectStackView.backgroundColor = schoolColor
        satSubjectStackView.layer.cornerRadius = 25
        
        satSubjectLabel.translatesAutoresizingMaskIntoConstraints = false
        satSubjectLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        satSubjectLabel.text = subjectName
        satSubjectLabel.textColor = .white
        satSubjectLabel.adjustsFontSizeToFitWidth = true
        satSubjectLabel.textAlignment = .center
        
        satSubjectScore.translatesAutoresizingMaskIntoConstraints = false
        satSubjectScore.font = UIFont(name:"HelveticaNeue", size: 100.0)
        satSubjectScore.text = "\(subjectScore)/800"
        satSubjectScore.textColor = .white
        satSubjectScore.adjustsFontSizeToFitWidth = true
        satSubjectScore.textAlignment = .center
    }
    
    func layout() {
        self.addSubview(satSubjectStackView)
        satSubjectStackView.addSubview(satSubjectLabel)
        satSubjectStackView.addSubview(satSubjectScore)
        
        NSLayoutConstraint.activate([
            satSubjectStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            satSubjectStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            satSubjectStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            satSubjectStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            satSubjectLabel.topAnchor.constraint(equalTo: satSubjectStackView.topAnchor),
            satSubjectLabel.heightAnchor.constraint(equalTo: satSubjectStackView.heightAnchor, multiplier: 0.4),
            satSubjectLabel.widthAnchor.constraint(equalTo: satSubjectStackView.widthAnchor, multiplier: 0.9),
            satSubjectLabel.centerXAnchor.constraint(equalTo: satSubjectStackView.centerXAnchor),
            satSubjectScore.topAnchor.constraint(equalTo: satSubjectLabel.bottomAnchor),
            satSubjectScore.heightAnchor.constraint(equalTo: satSubjectStackView.heightAnchor, multiplier: 0.3),
            satSubjectScore.widthAnchor.constraint(equalTo: satSubjectStackView.widthAnchor, multiplier: 0.8),
            satSubjectScore.centerXAnchor.constraint(equalTo: satSubjectStackView.centerXAnchor),
        ])
    }
}

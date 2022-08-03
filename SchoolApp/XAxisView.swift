//
//  XAxisView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class XAxisView: UIView {
    
    let mathLabel = UILabel()
    let writingLabel = UILabel()
    let readingLabel = UILabel()
    
    let subjectNames = ["SAT MATH", "SAT WRITING", "SAT CRITICAL READING"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        mathLabel.translatesAutoresizingMaskIntoConstraints = false
        mathLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        mathLabel.text = subjectNames[0]
        mathLabel.textAlignment = .center
        mathLabel.adjustsFontSizeToFitWidth = true
        mathLabel.numberOfLines = 0
        mathLabel.textColor = .black

        writingLabel.translatesAutoresizingMaskIntoConstraints = false
        writingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        writingLabel.text = subjectNames[1]
        writingLabel.textAlignment = .center
        writingLabel.adjustsFontSizeToFitWidth = true
        writingLabel.numberOfLines = 0
        writingLabel.textColor = .black

        readingLabel.translatesAutoresizingMaskIntoConstraints = false
        readingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        readingLabel.text = subjectNames[2]
        readingLabel.textAlignment = .center
        readingLabel.adjustsFontSizeToFitWidth = true
        readingLabel.numberOfLines = 0
        readingLabel.textColor = .black
    }
    
    func layout() {
        self.addSubview(mathLabel)
        self.addSubview(writingLabel)
        self.addSubview(readingLabel)
        
        NSLayoutConstraint.activate([
            mathLabel.topAnchor.constraint(equalTo: self.topAnchor),
            mathLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            mathLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            mathLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),

            writingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            writingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            writingLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            writingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),

            readingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            readingLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            readingLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            readingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
        ])
    }
}

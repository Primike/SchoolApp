//
//  XAxisView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class XAxisView: UIView {
    
    lazy var mathLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: subjectNames[0], labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        return label
    }()
    
    lazy var writingLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: subjectNames[1], labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        return label
    }()

    lazy var readingLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: subjectNames[2], labelTextColor: .black)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        return label
    }()
    
    let subjectNames = ["SAT MATH", "SAT WRITING", "SAT CRITICAL READING"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

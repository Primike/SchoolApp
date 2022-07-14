//
//  GraphBarsView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class GraphBarsView: UIView {
    
    let mathBar = UILabel()
    let writingBar = UILabel()
    let readingBar = UILabel()
    
    var schoolScores: SchoolScores
    let schoolColor: UIColor
    var graphHeightValues = [Float]()
    
    init(frame: CGRect, scores: SchoolScores, schoolColor: UIColor) {
        self.schoolColor = schoolColor
        self.schoolScores = scores
        
        let score1 = Int(scores.sat_math_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score1)/Double(800)))
        let score2 = Int(scores.sat_writing_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score2)/Double(800)))
        let score3 = Int(scores.sat_critical_reading_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score3)/Double(800)))
        
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        mathBar.translatesAutoresizingMaskIntoConstraints = false
        mathBar.backgroundColor = schoolColor
        mathBar.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        mathBar.text = schoolScores.sat_math_avg_score
        mathBar.textAlignment = .center
        mathBar.textColor = .white
        
        writingBar.translatesAutoresizingMaskIntoConstraints = false
        writingBar.backgroundColor = schoolColor
        writingBar.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        writingBar.text = schoolScores.sat_writing_avg_score
        writingBar.textAlignment = .center
        writingBar.textColor = .white
        
        readingBar.translatesAutoresizingMaskIntoConstraints = false
        readingBar.backgroundColor = schoolColor
        readingBar.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        readingBar.text = schoolScores.sat_critical_reading_avg_score
        readingBar.textAlignment = .center
        readingBar.textColor = .white
    }
    
    func layout() {
        self.addSubview(mathBar)
        self.addSubview(writingBar)
        self.addSubview(readingBar)
        
        NSLayoutConstraint.activate([
            mathBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            mathBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mathBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: CGFloat(graphHeightValues[0])),
            mathBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            
            writingBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            writingBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            writingBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: CGFloat(graphHeightValues[1])),
            writingBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            
            readingBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            readingBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            readingBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: CGFloat(graphHeightValues[2])),
            readingBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
        ])
    }
}

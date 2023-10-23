//
//  GraphBarsView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class GraphBarsView: UIView {
    
    lazy var mathBar: BarView = {
        let view = BarView(sectionScore: schoolScores.sat_math_avg_score, schoolColor: schoolColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var writingBar: BarView = {
        let view = BarView(sectionScore: schoolScores.sat_writing_avg_score, schoolColor: schoolColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var readingBar: BarView = {
        let view = BarView(sectionScore: schoolScores.sat_critical_reading_avg_score, schoolColor: schoolColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var mathBarHeightConstraint: NSLayoutConstraint?
    var writingBarHeightConstraint: NSLayoutConstraint?
    var readingBarHeightConstraint: NSLayoutConstraint?
    var schoolScores: SATData
    var schoolColor: UIColor
    var graphHeightValues = [Float]()
    
    init(scores: SATData, schoolColor: UIColor) {
        self.schoolColor = schoolColor
        self.schoolScores = scores
        
        let score1 = Int(scores.sat_math_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score1)/Double(800)))
        let score2 = Int(scores.sat_writing_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score2)/Double(800)))
        let score3 = Int(scores.sat_critical_reading_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score3)/Double(800)))
        
        super.init(frame: .zero)

        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(mathBar)
        self.addSubview(writingBar)
        self.addSubview(readingBar)
        
        mathBarHeightConstraint = mathBar.heightAnchor.constraint(equalToConstant: 0)
        writingBarHeightConstraint = writingBar.heightAnchor.constraint(equalToConstant: 0)
        readingBarHeightConstraint = readingBar.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            mathBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            mathBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mathBarHeightConstraint!,
            mathBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            
            writingBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            writingBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            writingBarHeightConstraint!,
            writingBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            
            readingBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            readingBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            readingBarHeightConstraint!,
            readingBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
        ])
    }

    func animateBars() {
        // Update height constraints to desired values
        mathBarHeightConstraint?.constant = self.frame.height * CGFloat(graphHeightValues[0])
        writingBarHeightConstraint?.constant = self.frame.height * CGFloat(graphHeightValues[1])
        readingBarHeightConstraint?.constant = self.frame.height * CGFloat(graphHeightValues[2])
        
        // Animate the changes
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }

}

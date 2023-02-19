//
//  GraphBarsComparisonView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class ComparisonBarsView: UIView {
    
    let mathStackView = UIStackView()
    let mathBar: BarView
    let mathBar2: BarView
    let writingStackView = UIStackView()
    let writingBar: BarView
    let writingBar2: BarView
    let readingStackView = UIStackView()
    let readingBar: BarView
    let readingBar2: BarView
    
    var schoolScores: SATScores
    let schoolScores2: SATScores
    let schoolColor: UIColor
    var graphHeightValues = [Float]()
    
    init(frame: CGRect, scores: SATScores, scores2: SATScores, schoolColor: UIColor) {
        self.schoolColor = schoolColor
        self.schoolScores = scores
        self.schoolScores2 = scores2
        
        let score1 = Int(scores.sat_math_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score1)/Double(800)))
        let score2 = Int(scores.sat_writing_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score2)/Double(800)))
        let score3 = Int(scores.sat_critical_reading_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score3)/Double(800)))
        let score4 = Int(scores2.sat_math_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score4)/Double(800)))
        let score5 = Int(scores2.sat_writing_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score5)/Double(800)))
        let score6 = Int(scores2.sat_critical_reading_avg_score) ?? 0
        graphHeightValues.append(Float(Double(score6)/Double(800)))
        
        mathBar = BarView(frame: CGRect(), sectionScore: scores.sat_math_avg_score, schoolColor: .black)
        writingBar = BarView(frame: CGRect(), sectionScore: scores.sat_writing_avg_score, schoolColor: .black)
        readingBar = BarView(frame: CGRect(), sectionScore: scores.sat_critical_reading_avg_score, schoolColor: .black)
        
        mathBar2 = BarView(frame: CGRect(), sectionScore: scores2.sat_math_avg_score, schoolColor: .brown)
        writingBar2 = BarView(frame: CGRect(), sectionScore: scores2.sat_writing_avg_score, schoolColor: .brown)
        readingBar2 = BarView(frame: CGRect(), sectionScore: scores2.sat_critical_reading_avg_score, schoolColor: .brown)

        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        mathStackView.translatesAutoresizingMaskIntoConstraints = false
        mathBar.translatesAutoresizingMaskIntoConstraints = false
        mathBar2.translatesAutoresizingMaskIntoConstraints = false

        writingStackView.translatesAutoresizingMaskIntoConstraints = false
        writingBar.translatesAutoresizingMaskIntoConstraints = false
        writingBar2.translatesAutoresizingMaskIntoConstraints = false

        readingStackView.translatesAutoresizingMaskIntoConstraints = false
        readingBar.translatesAutoresizingMaskIntoConstraints = false
        readingBar2.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func layout() {
        self.addSubview(mathStackView)
        self.addSubview(writingStackView)
        self.addSubview(readingStackView)
        
        mathStackView.addSubview(mathBar)
        mathStackView.addSubview(mathBar2)
        
        writingStackView.addSubview(writingBar)
        writingStackView.addSubview(writingBar2)
        
        readingStackView.addSubview(readingBar)
        readingStackView.addSubview(readingBar2)
        
        NSLayoutConstraint.activate([
            mathStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            mathStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mathStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            mathStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            
            mathBar.leftAnchor.constraint(equalTo: mathStackView.leftAnchor),
            mathBar.bottomAnchor.constraint(equalTo: mathStackView.bottomAnchor),
            mathBar.heightAnchor.constraint(equalTo: mathStackView.heightAnchor, multiplier: CGFloat(graphHeightValues[0])),
            mathBar.widthAnchor.constraint(equalTo: mathStackView.widthAnchor, multiplier: 0.45),
            
            mathBar2.rightAnchor.constraint(equalTo: mathStackView.rightAnchor),
            mathBar2.bottomAnchor.constraint(equalTo: mathStackView.bottomAnchor),
            mathBar2.heightAnchor.constraint(equalTo: mathStackView.heightAnchor, multiplier: CGFloat(graphHeightValues[3])),
            mathBar2.widthAnchor.constraint(equalTo: mathStackView.widthAnchor, multiplier: 0.45),
            
            writingStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            writingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            writingStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            writingStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            
            writingBar.leftAnchor.constraint(equalTo: writingStackView.leftAnchor),
            writingBar.bottomAnchor.constraint(equalTo: writingStackView.bottomAnchor),
            writingBar.heightAnchor.constraint(equalTo: writingStackView.heightAnchor, multiplier: CGFloat(graphHeightValues[1])),
            writingBar.widthAnchor.constraint(equalTo: writingStackView.widthAnchor, multiplier: 0.45),
            
            writingBar2.rightAnchor.constraint(equalTo: writingStackView.rightAnchor),
            writingBar2.bottomAnchor.constraint(equalTo: writingStackView.bottomAnchor),
            writingBar2.heightAnchor.constraint(equalTo: writingStackView.heightAnchor, multiplier: CGFloat(graphHeightValues[4])),
            writingBar2.widthAnchor.constraint(equalTo: writingStackView.widthAnchor, multiplier: 0.45),
            
            readingStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            readingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            readingStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            readingStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            
            readingBar.leftAnchor.constraint(equalTo: readingStackView.leftAnchor),
            readingBar.bottomAnchor.constraint(equalTo: readingStackView.bottomAnchor),
            readingBar.heightAnchor.constraint(equalTo: readingStackView.heightAnchor, multiplier: CGFloat(graphHeightValues[2])),
            readingBar.widthAnchor.constraint(equalTo: readingStackView.widthAnchor, multiplier: 0.45),
            
            readingBar2.rightAnchor.constraint(equalTo: readingStackView.rightAnchor),
            readingBar2.bottomAnchor.constraint(equalTo: readingStackView.bottomAnchor),
            readingBar2.heightAnchor.constraint(equalTo: readingStackView.heightAnchor, multiplier: CGFloat(graphHeightValues[5])),
            readingBar2.widthAnchor.constraint(equalTo: readingStackView.widthAnchor, multiplier: 0.45),
        ])
    }
}

//
//  GraphBarsComparisonView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class ComparisonBarsView: UIView {
    
    var sat1: SATData
    let sat2: SATData
    var graphHeightValues = [Float]()
    private var mathBar1HeightConstraint: NSLayoutConstraint?
    private var writingBar1HeightConstraint: NSLayoutConstraint?
    private var readingBar1HeightConstraint: NSLayoutConstraint?
    private var mathBar2HeightConstraint: NSLayoutConstraint?
    private var writingBar2HeightConstraint: NSLayoutConstraint?
    private var readingBar2HeightConstraint: NSLayoutConstraint?

    init(sat1: SATData, sat2: SATData) {
        self.sat1 = sat1
        self.sat2 = sat2
                
        super.init(frame: .zero)
        setup()
        layout()
    }

    // MARK: - Bars For The Graph
    lazy var mathStackView: SchoolAppStackView = {
        var view = SchoolAppStackView(type: .horizontal)
        return view
    }()
    
    lazy var mathBar: BarView = {
        var view = BarView(sectionScore: sat1.sat_math_avg_score, schoolColor: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var mathBar2: BarView = {
        var view = BarView(sectionScore: sat2.sat_math_avg_score, schoolColor: .brown)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var writingStackView: SchoolAppStackView = {
        var view = SchoolAppStackView(type: .horizontal)
        return view
    }()

    lazy var writingBar: BarView = {
        var view = BarView(sectionScore: sat1.sat_writing_avg_score, schoolColor: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var writingBar2: BarView = {
        var view = BarView(sectionScore: sat2.sat_writing_avg_score, schoolColor: .brown)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var readingStackView: SchoolAppStackView = {
        var view = SchoolAppStackView(type: .horizontal)
        return view
    }()

    lazy var readingBar: BarView = {
        var view = BarView(sectionScore: sat1.sat_critical_reading_avg_score, schoolColor: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var readingBar2: BarView = {
        var view = BarView(sectionScore: sat2.sat_critical_reading_avg_score, schoolColor: .brown)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Sets Up Bars Height Constraints
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.borderWidth = 3
        layer.borderColor = UIColor.black.cgColor
        
        let score1 = Int(sat1.sat_math_avg_score) ?? 0
        let score2 = Int(sat1.sat_writing_avg_score) ?? 0
        let score3 = Int(sat1.sat_critical_reading_avg_score) ?? 0
        let score4 = Int(sat2.sat_math_avg_score) ?? 0
        let score5 = Int(sat2.sat_writing_avg_score) ?? 0
        let score6 = Int(sat2.sat_critical_reading_avg_score) ?? 0

        graphHeightValues.append(Float(Double(score1)/Double(800)))
        graphHeightValues.append(Float(Double(score2)/Double(800)))
        graphHeightValues.append(Float(Double(score3)/Double(800)))
        graphHeightValues.append(Float(Double(score4)/Double(800)))
        graphHeightValues.append(Float(Double(score5)/Double(800)))
        graphHeightValues.append(Float(Double(score6)/Double(800)))
        
        mathBar1HeightConstraint = mathBar.heightAnchor.constraint(equalToConstant: 0)
        writingBar1HeightConstraint = writingBar.heightAnchor.constraint(equalToConstant: 0)
        readingBar1HeightConstraint = readingBar.heightAnchor.constraint(equalToConstant: 0)
        mathBar2HeightConstraint = mathBar2.heightAnchor.constraint(equalToConstant: 0)
        writingBar2HeightConstraint = writingBar2.heightAnchor.constraint(equalToConstant: 0)
        readingBar2HeightConstraint = readingBar2.heightAnchor.constraint(equalToConstant: 0)
    }
    
    private func layout() {
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
            mathBar1HeightConstraint!,
            mathBar.widthAnchor.constraint(equalTo: mathStackView.widthAnchor, multiplier: 0.45),
            
            mathBar2.rightAnchor.constraint(equalTo: mathStackView.rightAnchor),
            mathBar2.bottomAnchor.constraint(equalTo: mathStackView.bottomAnchor),
            mathBar2HeightConstraint!,
            mathBar2.widthAnchor.constraint(equalTo: mathStackView.widthAnchor, multiplier: 0.45),
            
            writingStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            writingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            writingStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            writingStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            
            writingBar.leftAnchor.constraint(equalTo: writingStackView.leftAnchor),
            writingBar.bottomAnchor.constraint(equalTo: writingStackView.bottomAnchor),
            writingBar1HeightConstraint!,
            writingBar.widthAnchor.constraint(equalTo: writingStackView.widthAnchor, multiplier: 0.45),
            
            writingBar2.rightAnchor.constraint(equalTo: writingStackView.rightAnchor),
            writingBar2.bottomAnchor.constraint(equalTo: writingStackView.bottomAnchor),
            writingBar2HeightConstraint!,
            writingBar2.widthAnchor.constraint(equalTo: writingStackView.widthAnchor, multiplier: 0.45),
            
            readingStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            readingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            readingStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            readingStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            
            readingBar.leftAnchor.constraint(equalTo: readingStackView.leftAnchor),
            readingBar.bottomAnchor.constraint(equalTo: readingStackView.bottomAnchor),
            readingBar1HeightConstraint!,
            readingBar.widthAnchor.constraint(equalTo: readingStackView.widthAnchor, multiplier: 0.45),
            
            readingBar2.rightAnchor.constraint(equalTo: readingStackView.rightAnchor),
            readingBar2.bottomAnchor.constraint(equalTo: readingStackView.bottomAnchor),
            readingBar2HeightConstraint!,
            readingBar2.widthAnchor.constraint(equalTo: readingStackView.widthAnchor, multiplier: 0.45),
        ])
    }
    
    func animateBars() {
        // Update height constraints to desired values
        mathBar1HeightConstraint?.constant = self.frame.height * CGFloat(graphHeightValues[0])
        writingBar1HeightConstraint?.constant = self.frame.height * CGFloat(graphHeightValues[1])
        readingBar1HeightConstraint?.constant = self.frame.height * CGFloat(graphHeightValues[2])
        mathBar2HeightConstraint?.constant = self.frame.height * CGFloat(graphHeightValues[3])
        writingBar2HeightConstraint?.constant = self.frame.height * CGFloat(graphHeightValues[4])
        readingBar2HeightConstraint?.constant = self.frame.height * CGFloat(graphHeightValues[5])

        // Animate the changes
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
}

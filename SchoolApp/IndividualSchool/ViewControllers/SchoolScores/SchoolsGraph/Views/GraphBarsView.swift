//
//  GraphBarsView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class GraphBarsView: UIView {
    
    private let satData: SATData
    private let schoolColor: UIColor
    private var graphHeightValues = [Double]()
    private var mathBarHeightConstraint: NSLayoutConstraint?
    private var writingBarHeightConstraint: NSLayoutConstraint?
    private var readingBarHeightConstraint: NSLayoutConstraint?
    
    init(satData: SATData, schoolColor: UIColor) {
        self.schoolColor = schoolColor
        self.satData = satData
                
        super.init(frame: .zero)

        setup()
        layout()
    }

    // MARK: - Bars For The Graph
    lazy var mathBar: BarView = {
        let view = BarView(sectionScore: satData.sat_math_avg_score, schoolColor: schoolColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var writingBar: BarView = {
        let view = BarView(sectionScore: satData.sat_writing_avg_score, schoolColor: schoolColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var readingBar: BarView = {
        let view = BarView(sectionScore: satData.sat_critical_reading_avg_score, schoolColor: schoolColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Sets Up Bars Height Constraints
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 3
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = .systemBackground

        let score1 = Double(satData.sat_math_avg_score) ?? 0
        let score2 = Double(satData.sat_writing_avg_score) ?? 0
        let score3 = Double(satData.sat_critical_reading_avg_score) ?? 0

        graphHeightValues.append(score1/Double(800))
        graphHeightValues.append(score2/Double(800))
        graphHeightValues.append(score3/Double(800))

        mathBarHeightConstraint = mathBar.heightAnchor.constraint(equalToConstant: 0)
        writingBarHeightConstraint = writingBar.heightAnchor.constraint(equalToConstant: 0)
        readingBarHeightConstraint = readingBar.heightAnchor.constraint(equalToConstant: 0)
    }
    
    private func layout() {
        self.addSubview(mathBar)
        self.addSubview(writingBar)
        self.addSubview(readingBar)
                
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

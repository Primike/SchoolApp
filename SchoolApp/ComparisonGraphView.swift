//
//  ComparisonGraphView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

//fix yaxis
class ComparisonGraphView: UIView {
    
    let legendView: LegendView
    let yAxisView = YAxisView()
    let comparisonBarsView: ComparisonBarsView
    let xAxisView = XAxisView()
    
    var schoolScores: SchoolScores
    let schoolScores2: SchoolScores
    let schoolColor: UIColor
    
    init(frame: CGRect, scores: SchoolScores, scores2: SchoolScores, schoolColor: UIColor) {
        self.schoolColor = schoolColor
        self.schoolScores = scores
        self.schoolScores2 = scores2
        
        self.legendView = LegendView(frame: CGRect(), schoolName1: "SCHOOL 1 doiscjiosdjciosjdcoijsc", schoolName2: "SCHOOL 1 doiscjiosdjciosjdcoijsc")
        self.comparisonBarsView = ComparisonBarsView(frame: CGRect(), scores: scores, scores2: scores2, schoolColor: schoolColor)
        
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        legendView.translatesAutoresizingMaskIntoConstraints = false
        
        yAxisView.translatesAutoresizingMaskIntoConstraints = false
        
        comparisonBarsView.translatesAutoresizingMaskIntoConstraints = false
        comparisonBarsView.layer.borderWidth = 3
        comparisonBarsView.layer.borderColor = UIColor.black.cgColor
        
        xAxisView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        self.addSubview(legendView)
        self.addSubview(yAxisView)
        self.addSubview(comparisonBarsView)
        self.addSubview(xAxisView)
        
        NSLayoutConstraint.activate([
            legendView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            legendView.rightAnchor.constraint(equalTo: self.rightAnchor),
            legendView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            legendView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            
            yAxisView.topAnchor.constraint(equalTo: legendView.bottomAnchor),
            yAxisView.leftAnchor.constraint(equalTo: self.leftAnchor),
            yAxisView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            yAxisView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            
            comparisonBarsView.topAnchor.constraint(equalTo: legendView.bottomAnchor),
            comparisonBarsView.rightAnchor.constraint(equalTo: self.rightAnchor),
            comparisonBarsView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            comparisonBarsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            xAxisView.topAnchor.constraint(equalTo: comparisonBarsView.bottomAnchor),
            xAxisView.leftAnchor.constraint(equalTo: comparisonBarsView.leftAnchor),
            xAxisView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            xAxisView.widthAnchor.constraint(equalTo: comparisonBarsView.widthAnchor),
        ])
    }
}

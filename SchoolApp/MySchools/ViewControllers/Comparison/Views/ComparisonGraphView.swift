//
//  ComparisonGraphView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class ComparisonGraphView: UIView {
    
    var school1: SchoolData
    let school2: SchoolData
    
    init(school1: SchoolData, school2: SchoolData) {
        self.school1 = school1
        self.school2 = school2
                
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var legendView: LegendView = {
        var view = LegendView(schoolName1: school1.school.school_name, schoolName2: school2.school.school_name)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var yAxisView: YAxisView = {
        var view = YAxisView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var xAxisView: XAxisView = {
        var view = XAxisView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var comparisonBarsView: ComparisonBarsView = {
        var view = ComparisonBarsView(sat1: school1.sat, sat2: school2.sat)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private func layout() {
        self.addSubview(legendView)
        self.addSubview(yAxisView)
        self.addSubview(comparisonBarsView)
        self.addSubview(xAxisView)
        
        NSLayoutConstraint.activate([
            legendView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            legendView.rightAnchor.constraint(equalTo: self.rightAnchor),
            legendView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            legendView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
            yAxisView.topAnchor.constraint(equalTo: legendView.bottomAnchor, constant: 8),
            yAxisView.leftAnchor.constraint(equalTo: self.leftAnchor),
            yAxisView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            yAxisView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            
            comparisonBarsView.topAnchor.constraint(equalTo: legendView.bottomAnchor, constant: 8),
            comparisonBarsView.rightAnchor.constraint(equalTo: self.rightAnchor),
            comparisonBarsView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            comparisonBarsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            xAxisView.topAnchor.constraint(equalTo: comparisonBarsView.bottomAnchor),
            xAxisView.leftAnchor.constraint(equalTo: comparisonBarsView.leftAnchor),
            xAxisView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            xAxisView.widthAnchor.constraint(equalTo: comparisonBarsView.widthAnchor),
        ])
    }
}

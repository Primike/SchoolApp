//
//  BarView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class BarView: UIView {
    
    lazy var bar: SchoolAppLabel = {
        var label = SchoolAppLabel(frame: CGRect(), labelText: sectionScore, labelTextColor: .white)
        label.backgroundColor = schoolColor
        label.font = UIFont(name:"HelveticaNeue", size: 30.0)
        return label
    }()
    
    let sectionScore: String
    let schoolColor: UIColor
    
    init(frame: CGRect, sectionScore: String, schoolColor: UIColor) {
        self.sectionScore = sectionScore
        self.schoolColor = schoolColor
    
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func layout() {
        self.addSubview(bar)
        
        NSLayoutConstraint.activate([
            bar.topAnchor.constraint(equalTo: self.topAnchor),
            bar.leftAnchor.constraint(equalTo: self.leftAnchor),
            bar.rightAnchor.constraint(equalTo: self.rightAnchor),
            bar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

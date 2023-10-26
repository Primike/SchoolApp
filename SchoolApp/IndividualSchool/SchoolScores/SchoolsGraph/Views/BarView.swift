//
//  BarView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class BarView: UIView {
    
    var sectionScore: String
    var schoolColor: UIColor
    
    init(sectionScore: String, schoolColor: UIColor) {
        self.sectionScore = sectionScore
        self.schoolColor = schoolColor
        
        super.init(frame: .zero)
    
        layout()
    }

    lazy var bar: SchoolAppLabel = {
        let label = SchoolAppLabel(labelText: sectionScore, fontSize: .largeTitle)
        label.backgroundColor = schoolColor
        label.font = UIFont(name:"HelveticaNeue", size: 30.0)
        label.textColor = .white
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        self.addSubview(bar)
        
        NSLayoutConstraint.activate([
            bar.topAnchor.constraint(equalTo: self.topAnchor),
            bar.leftAnchor.constraint(equalTo: self.leftAnchor),
            bar.rightAnchor.constraint(equalTo: self.rightAnchor),
            bar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

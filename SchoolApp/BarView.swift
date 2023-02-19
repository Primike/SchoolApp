//
//  BarView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class BarView: UIView {
    
    lazy var bar: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = schoolColor
        label.font = UIFont(name:"HelveticaNeue", size: 30.0)
        label.text = sectionScore
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
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

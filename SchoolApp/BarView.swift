//
//  BarView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit

class BarView: UIView {
    
    let bar = UILabel()
    
    let sectionScore: String
    let schoolColor: UIColor
    
    init(frame: CGRect, sectionScore: String, schoolColor: UIColor) {
        self.sectionScore = sectionScore
        self.schoolColor = schoolColor
    
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = schoolColor
        bar.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        bar.text = sectionScore
        bar.textAlignment = .center
        bar.textColor = .white
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

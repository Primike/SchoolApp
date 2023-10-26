//
//  SchoolAppStackView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/27/23.
//

import Foundation
import UIKit

class SchoolAppStackView: UIStackView {
    
    var type: NSLayoutConstraint.Axis
    
    init(type: NSLayoutConstraint.Axis) {
        self.type = type
        
        super.init(frame: .zero)
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = type
    }
}

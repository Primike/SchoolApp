//
//  SchoolAppStackView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/27/23.
//

import Foundation
import UIKit

class SchoolAppStackView: UIStackView {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

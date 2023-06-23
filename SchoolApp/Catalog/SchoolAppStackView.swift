//
//  SchoolAppStackView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/27/23.
//

import Foundation
import UIKit

class SchoolAppStackView: UIStackView {
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

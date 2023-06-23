//
//  SchoolAppTextField.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/27/23.
//

import Foundation
import UIKit

class SchoolAppTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name:"HelveticaNeue", size: 20.0)
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        layer.borderWidth = 3
        layer.cornerRadius = 7.0
        textColor = .black
        backgroundColor = .white
    }
}

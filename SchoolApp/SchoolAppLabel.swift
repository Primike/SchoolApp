//
//  SchoolAppLabel:.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/20/23.
//

import Foundation
import UIKit

class SchoolAppLabel: UILabel {
    
    private(set) var labelText: String
    private(set) var labelTextColor: UIColor
    
    required init(labelText: String, labelTextColor: UIColor) {
        self.labelText = labelText
        self.labelTextColor = labelTextColor
        
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        text = labelText
        textColor = labelTextColor
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        numberOfLines = 2
    }
}

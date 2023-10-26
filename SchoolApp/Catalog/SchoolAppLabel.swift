//
//  SchoolAppLabel:.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/20/23.
//

import Foundation
import UIKit

class SchoolAppLabel: UILabel {
    private let labelText: String
    private let fontSize: UIFont.TextStyle
    
    required init(labelText: String, fontSize: UIFont.TextStyle) {
        self.labelText = labelText
        self.fontSize = fontSize
        
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        let size = UIFont.preferredFont(forTextStyle: .headline).pointSize
        font = UIFont(name: "HelveticaNeue-Bold", size: size)
        text = labelText
        textColor = .black
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        numberOfLines = 1
    }
}

class SchoolAppLabel2: UILabel {
    
    private(set) var labelText: String
    private(set) var labelTextColor: UIColor
    
    required init(labelText: String, labelTextColor: UIColor = .black) {
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

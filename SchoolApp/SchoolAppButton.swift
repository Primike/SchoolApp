//
//  SchoolAppButton.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

import Foundation
import UIKit

class SchoolAppButton: UIButton {
    
    var title: String
    var viewWidth: CGFloat
    var imageName: String?
    var titleSize: CGFloat
    var imageSize:CGFloat
    
    init(title: String, viewWidth: CGFloat, imageName: String?, titleSize: CGFloat, imageSize: CGFloat) {
        self.title = title
        self.viewWidth = viewWidth
        self.imageName = imageName
        self.titleSize = titleSize
        self.imageSize = imageSize
        
        super.init(frame: CGRect())
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        configuration = SchoolAppButtonConfiguration.configuration
        configuration?.title = title
        configuration?.attributedTitle?.font = UIFont(name:"HelveticaNeue", size: CGFloat(Int(viewWidth))/titleSize)
        if let imageName = imageName {
            if let font = UIFont(name:"HelveticaNeue", size: CGFloat(Int(viewWidth))/imageSize) {
                configuration?.image = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(font: font))
            }
        }
    }
}

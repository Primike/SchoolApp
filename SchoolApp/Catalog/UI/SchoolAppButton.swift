//
//  SchoolAppButton.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

import Foundation
import UIKit

class SchoolAppButton: UIButton {
    
    private(set) var title: String
    private(set) var viewWidth: CGFloat
    private(set) var imageName: String?
    private(set) var titleSize: CGFloat
    private(set) var imageSize: CGFloat
    
    init(title: String, viewWidth: CGFloat, imageName: String? = nil, titleSize: CGFloat = 14.0, imageSize: CGFloat = 14.0) {
        self.title = title
        self.viewWidth = viewWidth
        self.imageName = imageName
        self.titleSize = titleSize
        self.imageSize = imageSize
        
        super.init(frame: .zero)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
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

//
//  MySchoolsEmptyView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/28/22.
//

import Foundation
import UIKit

class MySchoolsHeaderView: UIView {
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .horizontal)
        stackView.spacing = 10
        return stackView
    }()

    lazy var mySchoolsLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: "Add Schools And They Will Appear Here!", fontSize: .largeTitle)
        label.textColor = .white
        return label
    }()

    lazy var heartImage: UIImageView = {
        var image = UIImageView(image: UIImage(systemName: "heart.circle.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemRed
        return image
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .black

        layout()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
        
    func layout() {
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(heartImage)
        stackView.addArrangedSubview(mySchoolsLabel)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            heartImage.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3)
        ])
    }
}

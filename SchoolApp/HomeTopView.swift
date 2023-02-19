//
//  HomeTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class HomeTopView: UIView {
    
    lazy var schoolWallpaper: UIImageView = {
        var image = UIImageView(image: UIImage(named: "schoolwallpaper"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var pavementWallpaper: UIImageView = {
        var image = UIImageView(image: UIImage(named: "pavement"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(schoolWallpaper)
        self.addSubview(pavementWallpaper)

        NSLayoutConstraint.activate([
            schoolWallpaper.topAnchor.constraint(equalTo: self.topAnchor),
            schoolWallpaper.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55),
            schoolWallpaper.widthAnchor.constraint(equalTo: self.widthAnchor),
            schoolWallpaper.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            pavementWallpaper.topAnchor.constraint(equalTo: schoolWallpaper.bottomAnchor),
            pavementWallpaper.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45),
            pavementWallpaper.widthAnchor.constraint(equalTo: self.widthAnchor),
            pavementWallpaper.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}


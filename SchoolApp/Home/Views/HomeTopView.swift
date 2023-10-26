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
        var image = UIImageView(image: UIImage(named: HomeImageName.schoolWallpaper.rawValue))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()

    init() {
        super.init(frame: .zero)
        
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(schoolWallpaper)

        NSLayoutConstraint.activate([
            schoolWallpaper.topAnchor.constraint(equalTo: self.topAnchor),
            schoolWallpaper.heightAnchor.constraint(equalTo: self.heightAnchor),
            schoolWallpaper.widthAnchor.constraint(equalTo: self.widthAnchor),
            schoolWallpaper.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}


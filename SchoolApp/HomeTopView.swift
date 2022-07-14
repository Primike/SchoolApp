//
//  HomeTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

class HomeTopView: UIView {
    let wallpaper = UIImageView(image: UIImage(named: "schoolwallpaper"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        wallpaper.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        self.addSubview(wallpaper)
        
        NSLayoutConstraint.activate([
            wallpaper.topAnchor.constraint(equalTo: self.topAnchor),
            wallpaper.widthAnchor.constraint(equalTo: self.widthAnchor),
            wallpaper.heightAnchor.constraint(equalTo: self.heightAnchor),
            wallpaper.leftAnchor.constraint(equalTo: self.leftAnchor),
        ])
    }
}

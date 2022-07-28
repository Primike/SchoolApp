//
//  HomeTopView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/14/22.
//

import Foundation
import UIKit

//maybe a shader for image
class HomeTopView: UIView {
    let wallpaper = UIImageView(image: UIImage(named: "schoolwallpaper"))
    let wallpaper2 = UIImageView(image: UIImage(named: "pavement"))


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
        wallpaper2.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func layout() {
        self.addSubview(wallpaper)
        self.addSubview(wallpaper2)
        
        NSLayoutConstraint.activate([
            wallpaper.topAnchor.constraint(equalTo: self.topAnchor),
            wallpaper.widthAnchor.constraint(equalTo: self.widthAnchor),
            wallpaper.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55),
            wallpaper.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            wallpaper2.topAnchor.constraint(equalTo: wallpaper.bottomAnchor),
            wallpaper2.widthAnchor.constraint(equalTo: self.widthAnchor),
            wallpaper2.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45),
            wallpaper2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
        ])
    }
}

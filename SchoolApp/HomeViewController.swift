//
//  HomeViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    let buttonsTabView = UIView()
    
    override func viewDidLoad() {
        style()
        layout()
        
        super.viewDidLoad()
    }
    
    func style() {
        buttonsTabView.translatesAutoresizingMaskIntoConstraints = false
        buttonsTabView.layer.cornerRadius = 80
        buttonsTabView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        buttonsTabView.backgroundColor = .red
    }
    
    func layout() {
        view.addSubview(buttonsTabView)
        
        NSLayoutConstraint.activate([
            buttonsTabView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonsTabView.leftAnchor.constraint(equalTo: view.leftAnchor),
            buttonsTabView.rightAnchor.constraint(equalTo: view.rightAnchor),
            buttonsTabView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
        ])
    }
}

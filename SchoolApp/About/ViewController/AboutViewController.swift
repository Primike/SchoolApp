//
//  AboutViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 10/26/23.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    private let text = """
    This is a project I built which uses NYC school data and displays it.
    
    It uses the old 2400 SAT score, but while this isn't as useful anymore, this app still has its uses.
    
    My original assignment was to make it simple, but I decided to add to it and get creative with it.

    Over time, as I have become a stronger coder, I have completely improved the code and implemented MVVMC.
    
    I have also modified and greatly simplified features that were unnecessarily complex.
    
    I wanted to add as many things as I could so that if needed, I could have a reference to the UIKit methods.

    Now, I will focus on SwiftUI and plan on building a much more useful, much larger app that
    I've wanted to build for a while.
    """

    lazy var textLabel: SchoolAppLabel = {
        var label = SchoolAppLabel(labelText: text, fontSize: .largeTitle)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        view.backgroundColor = .white
        navigationItem.title = "About"
    }
    
    private func layout() {
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            textLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

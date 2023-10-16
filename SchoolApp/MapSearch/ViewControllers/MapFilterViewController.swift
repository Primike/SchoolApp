//
//  MapFilterViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 10/15/23.
//

import Foundation
import UIKit

class MapFilterViewController: UIViewController {
    
    let viewModel: MapSearchViewModel
    weak var coordinator: MapSearchCoordinator?

    init(viewModel: MapSearchViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var addressText: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let largeTitlePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        textField.font = UIFont(name: "HelveticaNeue-Bold", size: largeTitlePointSize)
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.layer.borderWidth = 3
        textField.layer.cornerRadius = 7.0
        textField.textColor = .black
        textField.backgroundColor = .white
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
}

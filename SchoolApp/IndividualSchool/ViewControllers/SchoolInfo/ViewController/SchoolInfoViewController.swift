//
//  SchoolInfoController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation
import UIKit

class SchoolInfoViewController: UIViewController, Coordinated {
    
    let defaults = UserDefaults.standard
    var addButtonImage: String
    private let viewModel: SchoolViewModel
    weak var coordinator: Coordinating?
    
    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        
        let savedArray = defaults.object(forKey: "array") as? [String] ?? [String]()
        
        if savedArray.contains(viewModel.school.dbn) {
            addButtonImage = "checkmark"
        } else {
            addButtonImage = "plus.circle"
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var screenStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .vertical
        return stackView
    }()

    lazy var schoolWebsiteButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("School Website", for: [])
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(websiteButtonTapped), for: .primaryActionTriggered)
        button.configuration = .filled()
        button.tintColor = viewModel.getColor(schoolBoro: viewModel.school.boro)
        return button
    }()
    
    lazy var addSchoolButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addSchool), for: .primaryActionTriggered)
        button.tintColor = viewModel.getColor(schoolBoro: viewModel.school.boro)
        button.titleLabel!.adjustsFontSizeToFitWidth = true
        button.setImage(UIImage(systemName: addButtonImage, withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)), for: .normal)
        return button
    }()
    
    lazy var schoolInfoBottomView: SchoolInfoBottomView = {
        var view = SchoolInfoBottomView(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMinYCorner]
        view.backgroundColor = viewModel.getColor(schoolBoro: viewModel.school.boro)
        return view
    }()
    
    lazy var schoolInfoTopView: SchoolInfoTopView = {
        var view = SchoolInfoTopView(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        layout()
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(screenStackView)
        screenStackView.addArrangedSubview(schoolInfoTopView)
        screenStackView.addArrangedSubview(schoolInfoBottomView)
        schoolInfoTopView.topButtonsStackView.addSubview(schoolWebsiteButton)
        schoolInfoTopView.topButtonsStackView.addSubview(addSchoolButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            screenStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            screenStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            screenStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            screenStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            screenStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.1),
            screenStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            schoolInfoTopView.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            schoolInfoTopView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.5),
            schoolInfoTopView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            schoolInfoTopView.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
            
            schoolWebsiteButton.leftAnchor.constraint(equalTo: schoolInfoTopView.topButtonsStackView.leftAnchor),
            schoolWebsiteButton.centerYAnchor.constraint(equalTo: schoolInfoTopView.topButtonsStackView.centerYAnchor),
            schoolWebsiteButton.widthAnchor.constraint(equalTo: schoolInfoTopView.topButtonsStackView.widthAnchor, multiplier: 0.5),
            
            addSchoolButton.rightAnchor.constraint(equalTo: schoolInfoTopView.topButtonsStackView.rightAnchor),
            addSchoolButton.heightAnchor.constraint(equalTo: schoolInfoTopView.topButtonsStackView.heightAnchor),
            addSchoolButton.widthAnchor.constraint(equalTo: schoolInfoTopView.topButtonsStackView.heightAnchor),
            addSchoolButton.centerYAnchor.constraint(equalTo: schoolInfoTopView.topButtonsStackView.centerYAnchor),
            
            schoolInfoTopView.schoolImage.rightAnchor.constraint(equalTo: addSchoolButton.rightAnchor),

            schoolInfoBottomView.topAnchor.constraint(equalTo: schoolInfoTopView.bottomAnchor),
            schoolInfoBottomView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.5),
            schoolInfoBottomView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
        ])
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Added To My Schools!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        }))

        present(alert, animated: true)
    }
}

extension SchoolInfoViewController {
    @objc func websiteButtonTapped(sender: UIButton) {
        guard let url = URL(string: "https://\(viewModel.school.website)") else {
            return
        }
        UIApplication.shared.open(url) { success in
            if success {
            }
        }
    }
    
    @objc func addSchool(sender: UIButton) {
        var savedArray = defaults.object(forKey: "array") as? [String] ?? [String]()

        if addButtonImage == "plus.circle" {
            addButtonImage = "checkmark"
            addSchoolButton.setImage(UIImage(systemName: addButtonImage, withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)), for: .normal)
            
            savedArray.append(viewModel.school.dbn)
            defaults.set(savedArray, forKey: "array")
            
            self.showAlert()
            
        } else {
            addButtonImage = "plus.circle"
            addSchoolButton.setImage(UIImage(systemName: addButtonImage, withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)), for: .normal)
            
            defaults.set(savedArray.filter { $0 != viewModel.school.dbn }, forKey: "array")
        }
    }
}



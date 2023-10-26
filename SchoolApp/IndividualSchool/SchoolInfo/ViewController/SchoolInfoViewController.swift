//
//  SchoolInfoController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation
import UIKit

class SchoolInfoViewController: UIViewController, Coordinated {
    
    weak var coordinator: Coordinating?
    private let viewModel: SchoolViewModel
    
    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        
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
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var infoTopView: SchoolInfoTopView = {
        var view = SchoolInfoTopView(viewModel: viewModel)
        return view
    }()

    lazy var infoBottomView: SchoolInfoBottomView = {
        var view = SchoolInfoBottomView(viewModel: viewModel)
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMinYCorner]
        view.backgroundColor = viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setup()
        layout()
    }
    
    private func setup() {
        infoTopView.websiteButton.addTarget(self, action: #selector(websiteButtonTapped), for: .primaryActionTriggered)
        infoTopView.addSchoolButton.addTarget(self, action: #selector(addSchool), for: .primaryActionTriggered)
        infoTopView.addSchoolButton.setImage(UIImage(systemName: viewModel.getAddSchoolButtonImageName(), withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)), for: .normal)
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(infoTopView)
        stackView.addArrangedSubview(infoBottomView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.1),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                                    
            infoTopView.schoolImage.rightAnchor.constraint(equalTo: infoTopView.addSchoolButton.rightAnchor),
        ])
    }
        
    private func showAlert() {
        let alert = UIAlertController(title: "Added To My Schools!", message: "", preferredStyle: .alert)
        
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension SchoolInfoViewController {
    @objc func websiteButtonTapped(sender: UIButton) {
        guard let url = viewModel.websiteURL else { return }
        UIApplication.shared.open(url) { success in }
    }
    
    @objc func addSchool(sender: UIButton) {
        NotificationCenter.default.post(name: .userDataDidUpdate, object: nil)
        
        let (imageName, willShowAlert) = viewModel.addOrRemoveSchool()
        
        infoTopView.addSchoolButton.setImage(UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold, scale: .large)), for: .normal)

        if willShowAlert { showAlert() }
    }
}

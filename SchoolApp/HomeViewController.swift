//
//  HomeViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()

    lazy var homeBottomView: HomeBottomView = {
        let view = HomeBottomView()
        return view
    }()
    
    lazy var homeTopView: HomeTopView = {
        let view = HomeTopView()
        return view
    }()

    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = view.layer.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor(red: 101/255, green: 37/255, blue: 122/255, alpha: 0.8).cgColor]
        return gradient
    }()
    
    lazy var schoolsListButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "NYC Schools List", viewWidth: view.bounds.width, imageName: "list.star", titleSize: 17, imageSize: 18)
        button.tag = 0
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        return button
    }()

    lazy var mapSearchButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "Map Search", viewWidth: view.bounds.width, imageName: "map", titleSize: 17, imageSize: 18)
        button.tag = 1
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        return button
    }()

    lazy var myschoolsButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "My Schools", viewWidth: view.bounds.width, imageName: "bolt.heart", titleSize: 17, imageSize: 18)
        button.tag = 2
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        return button
    }()

    lazy var topSchoolsButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "Top Schools", viewWidth: view.bounds.width, imageName: "star", titleSize: 30, imageSize: 32)
        button.tag = 3
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        return button
    }()

    lazy var satSearchButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "SAT Search", viewWidth: view.bounds.width, imageName: "books.vertical", titleSize: 30, imageSize: 32)
        button.tag = 4
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        return button
    }()
    
    let viewModel: HomeViewModel
    var coordinator: HomeCoordinator?


    required init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        if Reachability.isConnectedToNetwork() == false {
            showAlert(error: AlertErrors.noConnection.rawValue)
        }
        showLoader()
        fetchData()
        
        super.viewDidLoad()
    }
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "queue")
        
        dispatchGroup.enter()
        queue.async(group: dispatchGroup) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.viewModel.getSchools { result in
                switch result {
                case .success(_):
                    dispatchGroup.leave()
                case .failure(_):
                    DispatchQueue.main.async {
                        self.showAlert(error: AlertErrors.schoolDataError.rawValue)
                    }
                    dispatchGroup.leave()
                    return
                }
            }
        }
        
        dispatchGroup.enter()
        queue.async(group: dispatchGroup) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.viewModel.getSchoolScores { result in
                switch result {
                case .success(_):
                    dispatchGroup.leave()
                case .failure(_):
                    DispatchQueue.main.async {
                        self.showAlert(error: AlertErrors.satDataError.rawValue)
                    }
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else {
                return
            }
            
            for subview in self.view.subviews {
                subview.removeFromSuperview()
            }
            self.layout()
            self.homeTopView.layer.addSublayer(self.gradient)
        }
    }
    
    func showLoader() {
        self.view.addSubview(self.loadingView)
        NSLayoutConstraint.activate([
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.loadingView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func showAlert(error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        }))
        
        present(alert, animated: true)
    }
    
    func layout() {
        view.addSubview(homeTopView)
        view.addSubview(homeBottomView)
    
        homeBottomView.schoolsListStackView.addSubview(schoolsListButton)
        homeBottomView.mapSearchStackView.addSubview(mapSearchButton)
        homeBottomView.mySchoolsStackView.addSubview(myschoolsButton)
        homeBottomView.smallButtonsStackView.addSubview(topSchoolsButton)
        homeBottomView.smallButtonsStackView.addSubview(satSearchButton)
        
        NSLayoutConstraint.activate([
            homeTopView.topAnchor.constraint(equalTo: view.topAnchor),
            homeTopView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeTopView.rightAnchor.constraint(equalTo: view.rightAnchor),
            homeTopView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            homeBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeBottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeBottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
            homeBottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            
            schoolsListButton.heightAnchor.constraint(equalTo: homeBottomView.schoolsListStackView.heightAnchor, multiplier: 0.8),
            schoolsListButton.widthAnchor.constraint(equalTo: homeBottomView.schoolsListStackView.widthAnchor),
            schoolsListButton.centerXAnchor.constraint(equalTo: homeBottomView.centerXAnchor),
            schoolsListButton.centerYAnchor.constraint(equalTo: homeBottomView.schoolsListStackView.centerYAnchor),
            
            mapSearchButton.heightAnchor.constraint(equalTo: homeBottomView.mapSearchStackView.heightAnchor, multiplier: 0.8),
            mapSearchButton.widthAnchor.constraint(equalTo: homeBottomView.mapSearchStackView.widthAnchor),
            mapSearchButton.centerXAnchor.constraint(equalTo: homeBottomView.centerXAnchor),
            mapSearchButton.centerYAnchor.constraint(equalTo: homeBottomView.mapSearchStackView.centerYAnchor),
            
            myschoolsButton.heightAnchor.constraint(equalTo: homeBottomView.mySchoolsStackView.heightAnchor, multiplier: 0.8),
            myschoolsButton.widthAnchor.constraint(equalTo: homeBottomView.mySchoolsStackView.widthAnchor),
            myschoolsButton.centerXAnchor.constraint(equalTo: homeBottomView.centerXAnchor),
            myschoolsButton.centerYAnchor.constraint(equalTo: homeBottomView.mySchoolsStackView.centerYAnchor),
            
            topSchoolsButton.leftAnchor.constraint(equalTo: homeBottomView.smallButtonsStackView.leftAnchor),
            topSchoolsButton.heightAnchor.constraint(equalTo: homeBottomView.smallButtonsStackView.heightAnchor, multiplier: 0.6),
            topSchoolsButton.widthAnchor.constraint(equalTo: homeBottomView.smallButtonsStackView.widthAnchor, multiplier: 0.48),
            topSchoolsButton.centerYAnchor.constraint(equalTo: homeBottomView.smallButtonsStackView.centerYAnchor),
            
            satSearchButton.rightAnchor.constraint(equalTo: homeBottomView.smallButtonsStackView.rightAnchor),
            satSearchButton.heightAnchor.constraint(equalTo: homeBottomView.smallButtonsStackView.heightAnchor, multiplier: 0.6),
            satSearchButton.widthAnchor.constraint(equalTo: homeBottomView.smallButtonsStackView.widthAnchor, multiplier: 0.48),
            satSearchButton.centerYAnchor.constraint(equalTo: homeBottomView.smallButtonsStackView.centerYAnchor),
        ])
    }
}

extension HomeViewController {
    @objc func buttonTapped(sender: UIButton) {
        guard let coordinator = coordinator else {
            return
        }

        var type: ViewControllerType
        
        switch sender.tag {
        case 0:
            type = .schoolsList
        case 1:
            type = .mapSearch
        case 2:
            type = .mySchools
        case 3:
            type = .topSchools
        case 4:
            type = .satSearch
        default:
            return
        }
        
        coordinator.goToViewController(type: type, schools: viewModel.schools, schoolScores: viewModel.schoolsScores)
    }
}

//
//  HomeViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    let viewModel: HomeViewModel
    var coordinator: HomeCoordinator?

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
    
    lazy var schoolsListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nycSchoolsListTapped), for: .primaryActionTriggered)
        button.configuration = SchoolAppButtonConfiguration.configuration
        button.configuration?.title = "NYC Schools List"
        button.configuration?.attributedTitle?.font = UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/17)
        button.configuration?.image = UIImage(systemName: "list.star",
                                              withConfiguration: UIImage.SymbolConfiguration(font: UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/18)!))
        return button
    }()

    lazy var mapSearchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(mapSearchTapped), for: .primaryActionTriggered)
        button.configuration = SchoolAppButtonConfiguration.configuration
        button.configuration?.title = "Map Search"
        button.configuration?.attributedTitle?.font = UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/17)
        button.configuration?.image = UIImage(systemName: "map",
                                              withConfiguration: UIImage.SymbolConfiguration(font: UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/18)!))
        return button
    }()

    lazy var myschoolsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(mySchoolsTapped), for: .primaryActionTriggered)
        button.configuration = SchoolAppButtonConfiguration.configuration
        button.configuration?.title = "My Schools"
        button.configuration?.attributedTitle?.font = UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/17)
        button.configuration?.image = UIImage(systemName: "bolt.heart",
                                              withConfiguration: UIImage.SymbolConfiguration(font: UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/18)!))
        return button
    }()

    lazy var topSchoolsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(topSchoolsTapped), for: .primaryActionTriggered)
        button.configuration = SchoolAppButtonConfiguration.configuration
        button.configuration?.title = "Top Schools"
        button.configuration?.attributedTitle?.font = UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/30)
        button.configuration?.image = UIImage(systemName: "star",
                                                                        withConfiguration: UIImage.SymbolConfiguration(font: UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/32)!))
        return button
    }()

    lazy var satSearchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(satSearchTapped), for: .primaryActionTriggered)
        button.configuration = SchoolAppButtonConfiguration.configuration
        button.configuration?.title = "SAT Search"
        button.configuration?.attributedTitle?.font = UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/30)
        button.configuration?.image = UIImage(systemName: "books.vertical",
                                                                        withConfiguration: UIImage.SymbolConfiguration(font: UIFont(name:"HelveticaNeue", size: CGFloat(Int(view.bounds.width))/32)!))
        return button
    }()

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
    
        homeBottomView.schoolsListButtonView.addSubview(schoolsListButton)
        homeBottomView.mapSearchButtonView.addSubview(mapSearchButton)
        homeBottomView.mySchoolsButtonView.addSubview(myschoolsButton)
        homeBottomView.smallButtonsView.addSubview(topSchoolsButton)
        homeBottomView.smallButtonsView.addSubview(satSearchButton)
        
        NSLayoutConstraint.activate([
            homeTopView.topAnchor.constraint(equalTo: view.topAnchor),
            homeTopView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeTopView.rightAnchor.constraint(equalTo: view.rightAnchor),
            homeTopView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            homeBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeBottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeBottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
            homeBottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            
            schoolsListButton.heightAnchor.constraint(equalTo: homeBottomView.schoolsListButtonView.heightAnchor, multiplier: 0.8),
            schoolsListButton.widthAnchor.constraint(equalTo: homeBottomView.schoolsListButtonView.widthAnchor),
            schoolsListButton.centerXAnchor.constraint(equalTo: homeBottomView.centerXAnchor),
            schoolsListButton.centerYAnchor.constraint(equalTo: homeBottomView.schoolsListButtonView.centerYAnchor),
            
            mapSearchButton.heightAnchor.constraint(equalTo: homeBottomView.mapSearchButtonView.heightAnchor, multiplier: 0.8),
            mapSearchButton.widthAnchor.constraint(equalTo: homeBottomView.mapSearchButtonView.widthAnchor),
            mapSearchButton.centerXAnchor.constraint(equalTo: homeBottomView.centerXAnchor),
            mapSearchButton.centerYAnchor.constraint(equalTo: homeBottomView.mapSearchButtonView.centerYAnchor),
            
            myschoolsButton.heightAnchor.constraint(equalTo: homeBottomView.mySchoolsButtonView.heightAnchor, multiplier: 0.8),
            myschoolsButton.widthAnchor.constraint(equalTo: homeBottomView.mySchoolsButtonView.widthAnchor),
            myschoolsButton.centerXAnchor.constraint(equalTo: homeBottomView.centerXAnchor),
            myschoolsButton.centerYAnchor.constraint(equalTo: homeBottomView.mySchoolsButtonView.centerYAnchor),
            
            topSchoolsButton.leftAnchor.constraint(equalTo: homeBottomView.smallButtonsView.leftAnchor),
            topSchoolsButton.heightAnchor.constraint(equalTo: homeBottomView.smallButtonsView.heightAnchor, multiplier: 0.6),
            topSchoolsButton.widthAnchor.constraint(equalTo: homeBottomView.smallButtonsView.widthAnchor, multiplier: 0.48),
            topSchoolsButton.centerYAnchor.constraint(equalTo: homeBottomView.smallButtonsView.centerYAnchor),
            
            satSearchButton.rightAnchor.constraint(equalTo: homeBottomView.smallButtonsView.rightAnchor),
            satSearchButton.heightAnchor.constraint(equalTo: homeBottomView.smallButtonsView.heightAnchor, multiplier: 0.6),
            satSearchButton.widthAnchor.constraint(equalTo: homeBottomView.smallButtonsView.widthAnchor, multiplier: 0.48),
            satSearchButton.centerYAnchor.constraint(equalTo: homeBottomView.smallButtonsView.centerYAnchor),
        ])
    }
}

extension HomeViewController {
    @objc func nycSchoolsListTapped(sender: UIButton) {
//        navigationController?.pushViewController(SchoolsListViewController(viewModel: SchoolsListViewModel(schools: viewModel.schools, schoolsScores: viewModel.schoolsScores)), animated: true)
        guard let coordinator = coordinator else {
            return
        }
        
        coordinator.goToSchoolsList(schools: viewModel.schools, schoolScores: viewModel.schoolsScores)
    }
    
    @objc func mapSearchTapped(sender: UIButton) {
        navigationController?.pushViewController(MapSearchTabBarViewController(schools: viewModel.schools, schoolsScores: viewModel.schoolsScores), animated: true)
    }
    
    @objc func mySchoolsTapped(sender: UIButton) {
        navigationController?.pushViewController(MySchoolsTabBarViewController(viewModel: MySchoolsViewModel(schools: viewModel.schools, schoolsScores: viewModel.schoolsScores)), animated: true)
    }
    
    @objc func topSchoolsTapped(sender: UIButton) {
        navigationController?.pushViewController(TopSchoolsTabBarViewController(viewModel: TopSchoolsViewModel(schools: viewModel.schools, schoolsScores: viewModel.schoolsScores)), animated: true)
    }
    
    @objc func satSearchTapped(sender: UIButton) {
        navigationController?.pushViewController(SearchSATScoresTabBarViewController(viewModel: SearchSATScoresViewModel(schools: viewModel.schools, schoolsScores: viewModel.schoolsScores)), animated: true)
    }
}

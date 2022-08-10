//
//  HomeViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    let loadingView = LoadingView()
    let homeTopView = HomeTopView()
    let homeBottomView = HomeBottomView()
    
    let schoolsListButton = UIButton()
    let mapSearchButton = UIButton()
    let myschoolsButton = UIButton()
    let topSchoolsButton = UIButton()
    let satSearchButton = UIButton()

    let homeViewModel: HomeViewModel

    required init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.homeViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        homeViewModel.getSchools()
        
        super.viewDidLoad()
    }
    
    func style() {
        homeTopView.translatesAutoresizingMaskIntoConstraints = false
        
        homeBottomView.translatesAutoresizingMaskIntoConstraints = false
        homeBottomView.layer.cornerRadius = 70
        homeBottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        schoolsListButton.translatesAutoresizingMaskIntoConstraints = false
        schoolsListButton.addTarget(self, action: #selector(nycSchoolsListTapped), for: .primaryActionTriggered)
        schoolsListButton.setTitle("NYC Schools List", for: .normal)
        schoolsListButton.configuration = .filled()
        schoolsListButton.configuration?.baseBackgroundColor = .black
        
        mapSearchButton.translatesAutoresizingMaskIntoConstraints = false
        mapSearchButton.addTarget(self, action: #selector(mapSearchTapped), for: .primaryActionTriggered)
        mapSearchButton.setTitle("Map Search", for: .normal)
        mapSearchButton.configuration = .filled()
        mapSearchButton.configuration?.baseBackgroundColor = .black
        
        myschoolsButton.translatesAutoresizingMaskIntoConstraints = false
        myschoolsButton.addTarget(self, action: #selector(mySchoolsTapped), for: .primaryActionTriggered)
        myschoolsButton.setTitle("My Schools", for: .normal)
        myschoolsButton.configuration = .filled()
        myschoolsButton.configuration?.baseBackgroundColor = .black
        
        topSchoolsButton.translatesAutoresizingMaskIntoConstraints = false
        topSchoolsButton.addTarget(self, action: #selector(topSchoolsTapped), for: .primaryActionTriggered)
        topSchoolsButton.setTitle("Top Schools", for: .normal)
        topSchoolsButton.configuration = .filled()
        topSchoolsButton.configuration?.baseBackgroundColor = .black
        
        satSearchButton.translatesAutoresizingMaskIntoConstraints = false
        satSearchButton.addTarget(self, action: #selector(satSearchTapped), for: .primaryActionTriggered)
        satSearchButton.setTitle("SAT Search", for: .normal)
        satSearchButton.configuration = .filled()
        satSearchButton.configuration?.baseBackgroundColor = .black
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

extension HomeViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                self.loadingView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(self.loadingView)
                NSLayoutConstraint.activate([
                    self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
                    self.loadingView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                    self.loadingView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                    self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                ])
            case .success:
                for subview in self.view.subviews {
                    subview.removeFromSuperview()
                }
                self.style()
                self.layout()
            case .error(let error):
                if error.localizedDescription == "SAT Data Unavailable" || error.localizedDescription == "Local SAT Data Error"{
                    self.homeViewModel.state = .success
                }
                self.showAlert(error: error.localizedDescription)
            }
        }
    }
    
    func showAlert(error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: .alert)

        if error == "SAT Data Unavailable" {
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                self.homeViewModel.getSchoolScores()
            }))
            alert.addAction(UIAlertAction(title: "Use Local Data", style: .default, handler: { _ in
                self.homeViewModel.getLocalSchoolScores()
            }))
        }
        else if error == "Local SAT Data Error" {
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                self.homeViewModel.getLocalSchoolScores()
            }))
            alert.addAction(UIAlertAction(title: "Retry Online Data", style: .default, handler: { action in
                self.homeViewModel.getSchoolScores()
            }))
            alert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { _ in
            }))
        }
        else if error == "Local School Data Error" {
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                self.homeViewModel.getLocalSchools()
            }))
            alert.addAction(UIAlertAction(title: "Retry Online Data", style: .default, handler: { action in
                self.homeViewModel.getSchools()
            }))
            alert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { _ in
            }))
        } else {
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                self.homeViewModel.getSchools()
            }))
            alert.addAction(UIAlertAction(title: "Use Local Data", style: .default, handler: { _ in
                self.homeViewModel.getLocalSchools()
            }))
        }

        present(alert, animated: true)
    }
}

extension HomeViewController {
    @objc func nycSchoolsListTapped(sender: UIButton) {
        navigationController?.pushViewController(SchoolsListViewController(viewModel: SchoolsListViewModel(schools: homeViewModel.schools, schoolsScores: homeViewModel.schoolsScores)), animated: true)
    }
    
    @objc func mapSearchTapped(sender: UIButton) {
        navigationController?.pushViewController(MapSearchTabBarViewController(schools: homeViewModel.schools, schoolsScores: homeViewModel.schoolsScores), animated: true)
    }
    
    @objc func mySchoolsTapped(sender: UIButton) {
        navigationController?.pushViewController(MySchoolsTabBarViewController(viewModel: MySchoolsViewModel(schoolsSATData: homeViewModel.schoolsScores, schoolsData: homeViewModel.schools)), animated: true)
    }
    
    @objc func topSchoolsTapped(sender: UIButton) {
        navigationController?.pushViewController(TopSchoolsTabBarViewController(viewModel: TopSchoolsViewModel(schools: homeViewModel.schools, schoolsScores: homeViewModel.schoolsScores)), animated: true)
    }
    
    @objc func satSearchTapped(sender: UIButton) {
        navigationController?.pushViewController(SearchSATScoresTabBarViewController(viewModel: SearchSATScoresViewModel(schools: homeViewModel.schools, schoolsScores: homeViewModel.schoolsScores)), animated: true)
    }
}


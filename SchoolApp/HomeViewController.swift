//
//  HomeViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)

    let homeTopView = HomeTopView()
    let homeBottomView = HomeBottomView()
    
    let schoolsListButton = UIButton()
    let topSchoolsButton = UIButton()
    let myschoolsButton = UIButton()
    let nearbySchoolsButton = UIButton()
    let calculatorButton = UIButton()
    
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
        homeBottomView.backgroundColor = UIColor.systemRed
        
        schoolsListButton.translatesAutoresizingMaskIntoConstraints = false
        schoolsListButton.addTarget(self, action: #selector(nycSchoolsListTapped), for: .primaryActionTriggered)
        schoolsListButton.backgroundColor = .black
        schoolsListButton.setTitleColor(.white, for: .normal)
        schoolsListButton.setTitle("NYC Schools List", for: .normal)
        schoolsListButton.titleLabel!.font = UIFont(name:"HelveticaNeue", size: 23.0)
        schoolsListButton.titleLabel!.adjustsFontSizeToFitWidth = true
        schoolsListButton.layer.cornerRadius = 10
        schoolsListButton.titleLabel?.adjustsFontSizeToFitWidth = true

        topSchoolsButton.translatesAutoresizingMaskIntoConstraints = false
        topSchoolsButton.addTarget(self, action: #selector(top10SchoolsTapped), for: .primaryActionTriggered)
        topSchoolsButton.backgroundColor = .black
        topSchoolsButton.setTitleColor(.white, for: .normal)
        topSchoolsButton.setTitle("Top SAT Schools", for: .normal)
        topSchoolsButton.titleLabel!.font = UIFont(name:"HelveticaNeue", size: 23.0)
        topSchoolsButton.titleLabel!.adjustsFontSizeToFitWidth = true
        topSchoolsButton.layer.cornerRadius = 10
        topSchoolsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        myschoolsButton.translatesAutoresizingMaskIntoConstraints = false
        myschoolsButton.addTarget(self, action: #selector(mySchoolsTapped), for: .primaryActionTriggered)
        myschoolsButton.backgroundColor = .black
        myschoolsButton.setTitleColor(.white, for: .normal)
        myschoolsButton.setTitle("My Schools", for: .normal)
        myschoolsButton.titleLabel!.font = UIFont(name:"HelveticaNeue", size: 23.0)
        myschoolsButton.titleLabel!.adjustsFontSizeToFitWidth = true
        myschoolsButton.layer.cornerRadius = 10
        myschoolsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        nearbySchoolsButton.translatesAutoresizingMaskIntoConstraints = false
        nearbySchoolsButton.addTarget(self, action: #selector(nearbySchoolsTapped), for: .primaryActionTriggered)
        nearbySchoolsButton.backgroundColor = .black
        nearbySchoolsButton.setTitleColor(.white, for: .normal)
        nearbySchoolsButton.setTitle("Nearby Schools", for: .normal)
        nearbySchoolsButton.titleLabel!.font = UIFont(name:"HelveticaNeue", size: 16.0)
        nearbySchoolsButton.titleLabel!.adjustsFontSizeToFitWidth = true
        nearbySchoolsButton.layer.cornerRadius = 10
        nearbySchoolsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        calculatorButton.translatesAutoresizingMaskIntoConstraints = false
        calculatorButton.addTarget(self, action: #selector(calculatorTapped), for: .primaryActionTriggered)
        calculatorButton.backgroundColor = .black
        calculatorButton.setTitleColor(.white, for: .normal)
        calculatorButton.setTitle("Search By SAT Score", for: .normal)
        calculatorButton.titleLabel!.font = UIFont(name:"HelveticaNeue", size: 16.0)
        calculatorButton.titleLabel!.adjustsFontSizeToFitWidth = true
        calculatorButton.layer.cornerRadius = 10
        calculatorButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func layout() {
        
        view.addSubview(homeTopView)
        view.addSubview(homeBottomView)
        
        homeBottomView.schoolsListButtonView.addSubview(schoolsListButton)
        homeBottomView.topSchoolsButtonView.addSubview(topSchoolsButton)
        homeBottomView.mySchoolsButtonView.addSubview(myschoolsButton)
        homeBottomView.extraButtonsView.addSubview(nearbySchoolsButton)
        homeBottomView.extraButtonsView.addSubview(calculatorButton)
        
        
        NSLayoutConstraint.activate([
            homeTopView.topAnchor.constraint(equalTo: view.topAnchor),
            homeTopView.widthAnchor.constraint(equalTo: view.widthAnchor),
            homeTopView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            homeTopView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            homeBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeBottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeBottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
            homeBottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            
            schoolsListButton.widthAnchor.constraint(equalTo: homeBottomView.schoolsListButtonView.widthAnchor),
            schoolsListButton.centerXAnchor.constraint(equalTo: homeBottomView.centerXAnchor),
            schoolsListButton.centerYAnchor.constraint(equalTo: homeBottomView.schoolsListButtonView.centerYAnchor),
            schoolsListButton.heightAnchor.constraint(equalTo: homeBottomView.schoolsListButtonView.heightAnchor, multiplier: 0.8),
            
            topSchoolsButton.widthAnchor.constraint(equalTo: homeBottomView.topSchoolsButtonView.widthAnchor),
            topSchoolsButton.centerXAnchor.constraint(equalTo: homeBottomView.centerXAnchor),
            topSchoolsButton.centerYAnchor.constraint(equalTo: homeBottomView.topSchoolsButtonView.centerYAnchor),
            topSchoolsButton.heightAnchor.constraint(equalTo: homeBottomView.topSchoolsButtonView.heightAnchor, multiplier: 0.8),
            
            myschoolsButton.widthAnchor.constraint(equalTo: homeBottomView.mySchoolsButtonView.widthAnchor),
            myschoolsButton.centerXAnchor.constraint(equalTo: homeBottomView.centerXAnchor),
            myschoolsButton.centerYAnchor.constraint(equalTo: homeBottomView.mySchoolsButtonView.centerYAnchor),
            myschoolsButton.heightAnchor.constraint(equalTo: homeBottomView.mySchoolsButtonView.heightAnchor, multiplier: 0.8),
            
            nearbySchoolsButton.widthAnchor.constraint(equalTo: homeBottomView.extraButtonsView.widthAnchor, multiplier: 0.48),
            nearbySchoolsButton.leftAnchor.constraint(equalTo: homeBottomView.extraButtonsView.leftAnchor),
            nearbySchoolsButton.heightAnchor.constraint(equalTo: homeBottomView.extraButtonsView.heightAnchor, multiplier: 0.6),
            nearbySchoolsButton.centerYAnchor.constraint(equalTo: homeBottomView.extraButtonsView.centerYAnchor),
            
            calculatorButton.widthAnchor.constraint(equalTo: homeBottomView.extraButtonsView.widthAnchor, multiplier: 0.48),
            calculatorButton.rightAnchor.constraint(equalTo: homeBottomView.extraButtonsView.rightAnchor),
            calculatorButton.heightAnchor.constraint(equalTo: homeBottomView.extraButtonsView.heightAnchor, multiplier: 0.6),
            calculatorButton.centerYAnchor.constraint(equalTo: homeBottomView.extraButtonsView.centerYAnchor),
            
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
                self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                self.activityIndicator.startAnimating()
                self.activityIndicator.color = .systemBlue
                self.view.addSubview(self.activityIndicator)
                self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            case .success:
                self.activityIndicator.stopAnimating()
                self.style()
                self.layout()
            case .error(let error):
                if error.localizedDescription == "SAT Data Unavailable" {
                    self.homeViewModel.state = .success
                }
                self.showAlert(error: error.localizedDescription)                
            }
        }
    }
    
    
    func showAlert(error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { _ in
//            exit(0)
        }))
        if error == "SAT Data Unavailable" {
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                self.homeViewModel.getSchoolScores()
            }))
        } else {
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                self.homeViewModel.getSchools()
            }))
        }

        
        present(alert, animated: true)
    }
}
extension HomeViewController {
    @objc func nycSchoolsListTapped(sender: UIButton) {
        navigationController?.pushViewController(SchoolsListViewController(viewModel: SchoolsListViewModel(schools: homeViewModel.schools, schoolsScores: homeViewModel.schoolsScores)), animated: true)
    }
    
    @objc func top10SchoolsTapped(sender: UIButton) {
        navigationController?.pushViewController(TopSchoolsListViewController(viewModel: TopSchoolsListViewModel(schools: homeViewModel.schools, schoolsScores: homeViewModel.schoolsScores)), animated: true)
    }
    
    @objc func mySchoolsTapped(sender: UIButton) {
        navigationController?.pushViewController(MySchoolsViewController(viewModel: MySchoolsViewModel(schoolsSATData: homeViewModel.schoolsScores, schoolsData: homeViewModel.schools)), animated: true)
    }
    
    @objc func nearbySchoolsTapped(sender: UIButton) {
        navigationController?.pushViewController(NearbySchoolsViewController(viewModel: NearbySchoolsViewModel(schoolsSATData: homeViewModel.schoolsScores, schoolsData: homeViewModel.schools)), animated: true)
    }
    
    @objc func calculatorTapped(sender: UIButton) {
        navigationController?.pushViewController(SchoolsCalculatorViewController(viewModel: SchoolsCalculatorViewModel(schoolsSATData: homeViewModel.schoolsScores, schoolsData: homeViewModel.schools)), animated: true)
    }
}


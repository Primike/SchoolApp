//
//  HomeViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let homeTopView = HomeTopView()
    let homeBottomView = HomeBottomView()
    
    let buttonsStackView = UIStackView()
    let schoolsListButton = UIButton()
    let topSchoolsButton = UIButton()
    let myschoolsButton = UIButton()
    
    let viewModel: HomeViewModel
    


    required init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        viewModel.loadData()
        super.viewDidLoad()
    }
    
    func style() {

        homeTopView.translatesAutoresizingMaskIntoConstraints = false
        
        homeBottomView.translatesAutoresizingMaskIntoConstraints = false
        homeBottomView.layer.cornerRadius = 70
        homeBottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        homeBottomView.backgroundColor = UIColor.systemRed
        
        
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .vertical
        
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
        topSchoolsButton.setTitle("Top 10 SAT Schools", for: .normal)
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
    }
    
    func layout() {
        
        view.addSubview(homeTopView)
        view.addSubview(homeBottomView)
        
        homeBottomView.addSubview(buttonsStackView)

        buttonsStackView.addSubview(schoolsListButton)
        buttonsStackView.addSubview(topSchoolsButton)
        buttonsStackView.addSubview(myschoolsButton)
        
        
        NSLayoutConstraint.activate([
            homeTopView.topAnchor.constraint(equalTo: view.topAnchor),
            homeTopView.widthAnchor.constraint(equalTo: view.widthAnchor),
            homeTopView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            homeTopView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            homeBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeBottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeBottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
            homeBottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            
            
            
            buttonsStackView.heightAnchor.constraint(equalTo: homeBottomView.heightAnchor, multiplier: 0.4),
            buttonsStackView.widthAnchor.constraint(equalTo: homeBottomView.widthAnchor, multiplier: 0.7),
            buttonsStackView.centerXAnchor.constraint(equalTo: homeBottomView.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: homeBottomView.centerYAnchor),
            
            schoolsListButton.topAnchor.constraint(equalTo: buttonsStackView.topAnchor),
            schoolsListButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            schoolsListButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.25),
            
            topSchoolsButton.centerYAnchor.constraint(equalTo: buttonsStackView.centerYAnchor),
            topSchoolsButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            topSchoolsButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.25),
            
            myschoolsButton.bottomAnchor.constraint(equalTo: buttonsStackView.bottomAnchor),
            myschoolsButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            myschoolsButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.25),
            
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
                let activityIndicator = UIActivityIndicatorView(style: .large)
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                activityIndicator.startAnimating()
                activityIndicator.color = .systemBlue
                self.view.addSubview(activityIndicator)
                activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            case .success:
                self.style()
                self.layout()
            case .error(let error):
                self.showAlert(error: error.localizedDescription)
            }
        }
    }
    
    
    func showAlert(error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { _ in
//            exit(0)
        }))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.viewModel.loadData()
        }))
        
        present(alert, animated: true)
    }
}
extension HomeViewController {
    @objc func nycSchoolsListTapped(sender: UIButton) {
        navigationController?.pushViewController(SchoolsListViewController(viewModel: SchoolsListViewModel(schoolsSATData: viewModel.schoolsSATData, schoolsData: viewModel.schoolsData, schoolSearchResults: viewModel.schoolsSearchResults)), animated: true)
    }
    
    @objc func top10SchoolsTapped(sender: UIButton) {
        navigationController?.pushViewController(Top10SchoolsListViewController(viewModel: Top10SchoolsListViewModel(schoolsSATData: viewModel.top10SchoolsScores, schoolsData: viewModel.top10Schools)), animated: true)
    }
    
    @objc func mySchoolsTapped(sender: UIButton) {
//        navigationController?.pushViewController(MySchoolsViewController(viewModel: MySchoolsViewModel(schoolsSATData: viewModel.schoolsSATData, schoolsData: viewModel.schoolsData)), animated: true)
        navigationController?.pushViewController(SchoolsCalculatorViewController(schoolData: viewModel.schoolsData, schoolSATData: viewModel.schoolsSATData), animated: true)
    }
}


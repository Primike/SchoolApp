//
//  HomeViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit
import Network

class HomeViewController: UIViewController, HomeViewModelDelegate {
    
    let viewModel: HomeViewModel
    weak var coordinator: HomeCoordinator?

    required init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var loaderView: LoaderView = {
        let view = LoaderView()
        return view
    }()

    lazy var homeBottomView: HomeBottomView = {
        let view = HomeBottomView(viewWidth: view.frame.width)
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
            
    override func viewDidLoad() {
        if !Reachability.isConnected {
            showAlert(error: AlertErrors.noConnection.rawValue)
        }
        
        displayLoader()
        viewModel.fetchData()
        viewModel.delegate = self
        
        super.viewDidLoad()
    }
    
    func showAlert(error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        }))
        
        present(alert, animated: true)
    }

    func displayLoader() {
        view.addSubview(loaderView)
        
        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: view.topAnchor),
            loaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func didUpdate() {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        
        addButtons()
        layout()
        homeTopView.layer.addSublayer(gradient)
    }

    func addButtons() {
        homeBottomView.schoolsListButton.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        homeBottomView.mapSearchButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        homeBottomView.myschoolsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        homeBottomView.topSchoolsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        homeBottomView.satSearchButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    }
            
    func layout() {
        view.addSubview(homeTopView)
        view.addSubview(homeBottomView)
            
        NSLayoutConstraint.activate([
            homeTopView.topAnchor.constraint(equalTo: view.topAnchor),
            homeTopView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeTopView.rightAnchor.constraint(equalTo: view.rightAnchor),
            homeTopView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            homeBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeBottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeBottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
            homeBottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
                        
        ])
    }
}

extension HomeViewController {
    @objc func buttonTapped(sender: UIButton) {
        guard let coordinator = coordinator else { return }

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
        
        coordinator.goToViewController(type: type, schools: viewModel.schools, schoolScores: viewModel.satScores)
    }
}

//
//  HomeViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/30/22.
//

import Foundation
import UIKit
import Network

final class HomeViewController: UIViewController, HomeViewModelDelegate {
    
    private(set) var viewModel: HomeViewModeling
    weak var coordinator: HomeCoordinator?

    required init(viewModel: HomeViewModeling) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var loaderView: LoaderView = {
        let view = LoaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var homeTopView: HomeTopView = {
        let view = HomeTopView()
        return view
    }()

    lazy var homeBottomView: HomeBottomView = {
        let view = HomeBottomView(viewWidth: view.frame.width)
        return view
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = view.layer.bounds
        gradient.colors = [
            UIColor(red: 200/255, green: 185/255, blue: 150/255, alpha: 0.6).cgColor,
            UIColor(red: 37/255, green: 22/255, blue: 15/255, alpha: 0.8).cgColor ]
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
    }

    func showAlert(error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in }))
        
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
        homeBottomView.layer.insertSublayer(gradient, at: 0)
    }

    func addButtons() {
        homeBottomView.schoolsListButton.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        homeBottomView.schoolsListButton.addTarget(self, action: #selector(buttonTapped), for: [.touchUpInside, .touchUpOutside])

        homeBottomView.mapSearchButton.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        homeBottomView.mapSearchButton.addTarget(self, action: #selector(buttonTapped), for: [.touchUpInside, .touchUpOutside])

        homeBottomView.myschoolsButton.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        homeBottomView.myschoolsButton.addTarget(self, action: #selector(buttonTapped), for: [.touchUpInside, .touchUpOutside])

        homeBottomView.about.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        homeBottomView.about.addTarget(self, action: #selector(buttonTapped), for: [.touchUpInside, .touchUpOutside])        
    }
            
    func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(homeTopView)
        stackView.addArrangedSubview(homeBottomView)
            
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController {
    @objc func buttonTouched(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }
    }

    @objc func buttonTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }

        guard let type = ViewControllerType(rawValue: sender.tag) else { return }
    
        coordinator?.goToViewController(type: type, schoolsData: viewModel.getSchoolsData())
    }
}

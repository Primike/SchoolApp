//
//  MoreViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/16/22.
//

import Foundation
import UIKit



class ViewController: UIViewController {
    
    let stackView = UIStackView()
    let pushButton = UIButton(type: .system)
    let presentButton = UIButton(type: .system)

    var x = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }
  
}

extension ViewController {
    func style() {
        title = "NavBar Demo"

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.configuration = .filled()
        pushButton.setTitle("Push", for: [])
        pushButton.addTarget(self, action: #selector(pushButtonTapped), for: .primaryActionTriggered)
        
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.configuration = .filled()
        presentButton.setTitle("Present", for: [])
        presentButton.addTarget(self, action: #selector(presentButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(pushButton)
        stackView.addArrangedSubview(presentButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension ViewController {
    @objc func pushButtonTapped(sender: UIButton) {
        navigationController?.pushViewController(PushViewController(), animated: true)
    }
    
    @objc func presentButtonTapped(sender: UIButton) {
        navigationController?.present(PresentViewController(), animated: true, completion: nil)
    }
}



class PushViewController: UIViewController {
    
    let stackView = UIStackView()
    let popButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style() {
        title = "Pushed ViewController"
        view.backgroundColor = .systemOrange

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        popButton.translatesAutoresizingMaskIntoConstraints = false
        popButton.configuration = .filled()
        popButton.setTitle("Pop", for: [])
        popButton.addTarget(self, action: #selector(popTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(popButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func popTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}


class PresentViewController: UIViewController {
    
    let stackView = UIStackView()
    let dismissButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style() {
        title = "Not shown"
        view.backgroundColor = .systemPurple

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.configuration = .filled()
        dismissButton.setTitle("Dismiss", for: [])
        dismissButton.addTarget(self, action: #selector(dismissTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(dismissButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func dismissTapped(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


//class MoreViewController: UIViewController {
//    private let scrollView: UIScrollView = {
//        let view = UIScrollView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    private let scrollStackViewContainer: UIStackView = {
//        let view = UIStackView()
//        view.axis = .vertical
//        view.spacing = 0
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    private let subView1: UIView = {
//        let view = UIView()
//        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        view.backgroundColor = UIColor.blue
//        return view
//    }()
//    private let subview2: UIView = {
//        let view = UIView()
//        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        view.backgroundColor = UIColor.cyan
//        return view
//    }()
//    private let subview3: UIView = {
//        let view = UIView()
//        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
//        view.backgroundColor = UIColor.gray
//        view.layer.cornerRadius = 50
//        view.layer.maskedCorners = [.layerMinXMinYCorner]
//        return view
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupScrollView()
//    }
//
//    private func setupScrollView() {
//        let margins = view.layoutMarginsGuide
//        view.addSubview(scrollView)
//
//        scrollView.addSubview(scrollStackViewContainer)
//        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        scrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
//
//        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
//        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
//        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//        configureContainerView()
//    }
//    private func configureContainerView() {
//        scrollStackViewContainer.addArrangedSubview(subView1)
//        scrollStackViewContainer.addArrangedSubview(subview2)
//        scrollStackViewContainer.addArrangedSubview(subview3)
//    }
//}

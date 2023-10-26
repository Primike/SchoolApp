//
//  TestsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation
import UIKit

class SchoolScoresViewController: UIViewController, Coordinated {
    
    private let viewModel: SchoolViewModel
    weak var coordinator: Coordinating?
    
    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var schoolScoresTopView: SchoolScoresTopView = {
        var view = SchoolScoresTopView(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var schoolScoresBottomView: SchoolScoresBottomView = {
        var view = SchoolScoresBottomView(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    lazy var screenStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        schoolScoresTopView.graphButton.addTarget(self, action: #selector(graphButtonTapped), for: .touchUpInside)

        schoolScoresTopView.backgroundColor = viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro)
                
        
        if viewModel.schoolData.sat.sat_math_avg_score == "0" {
            schoolScoresBottomView.satMathSubView.satSubjectScore.text = "Not Available"
            schoolScoresBottomView.satWritingSubView.satSubjectScore.text = "Not Available"
            schoolScoresBottomView.satReadingSubView.satSubjectScore.text = "Not Available"
        }
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(screenStackView)

        screenStackView.addSubview(schoolScoresTopView)
        screenStackView.addSubview(schoolScoresBottomView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            screenStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            screenStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            screenStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            screenStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            screenStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1),
            screenStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            schoolScoresTopView.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            schoolScoresTopView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.3),
            schoolScoresTopView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            schoolScoresTopView.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
                        
            schoolScoresBottomView.topAnchor.constraint(equalTo: schoolScoresTopView.bottomAnchor),
            schoolScoresBottomView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.6),
            schoolScoresBottomView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
        ])
    }
}

extension SchoolScoresViewController {
    @objc func graphButtonTapped(sender: UIButton) {
        navigationController?.present(SchoolGraphViewController(viewModel: viewModel), animated: true, completion: nil)
    }
}

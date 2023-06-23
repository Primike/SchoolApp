//
//  TestGraph.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/7/22.
//

import Foundation
import UIKit

class SchoolGraphViewController: UIViewController {

    lazy var screenStackView: SchoolAppStackView = {
        let stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var arrowImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "arrow.down"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()

    lazy var schoolNameLabel: SchoolAppLabel = {
        let label = SchoolAppLabel(labelText: viewModel.school.school_name, labelTextColor: schoolColor)
        label.numberOfLines = 1
        return label
    }()

    lazy var topStackView: SchoolAppStackView = {
        let stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var yAxisView: YAxisView = {
        let view = YAxisView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var graphBarsView: GraphBarsView = {
        let view = GraphBarsView(scores: viewModel.satData, schoolColor: schoolColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .systemBackground
        return view
    }()
    lazy var xAxisView: XAxisView = {
        let view = XAxisView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let schoolColor: UIColor
    let viewModel: SchoolViewModel

    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        self.schoolColor = viewModel.getColor(schoolBoro: viewModel.school.boro)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        layout()
    }
    
    private func layout() {
        view.addSubview(screenStackView)

        screenStackView.addSubview(arrowImage)
        screenStackView.addSubview(schoolNameLabel)
        screenStackView.addSubview(topStackView)
        screenStackView.addSubview(xAxisView)
        
        topStackView.addSubview(yAxisView)
        topStackView.addSubview(graphBarsView)
        
        NSLayoutConstraint.activate([
            screenStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            screenStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            screenStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            arrowImage.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            arrowImage.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.05),
            arrowImage.widthAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.05),
            arrowImage.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
            
            schoolNameLabel.topAnchor.constraint(equalTo: arrowImage.bottomAnchor),
            schoolNameLabel.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.1),
            schoolNameLabel.widthAnchor.constraint(equalTo: screenStackView.widthAnchor, multiplier: 0.9),
            schoolNameLabel.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
            
            topStackView.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor),
            topStackView.leftAnchor.constraint(equalTo: screenStackView.leftAnchor),
            topStackView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.8),
            topStackView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor),
            
            yAxisView.topAnchor.constraint(equalTo: topStackView.topAnchor),
            yAxisView.leftAnchor.constraint(equalTo: topStackView.leftAnchor),
            yAxisView.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            yAxisView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.1),
            
            graphBarsView.topAnchor.constraint(equalTo: topStackView.topAnchor),
            graphBarsView.leftAnchor.constraint(equalTo: yAxisView.rightAnchor),
            graphBarsView.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            graphBarsView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.9),
            
            xAxisView.widthAnchor.constraint(equalTo: graphBarsView.widthAnchor),
            xAxisView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.05),
            xAxisView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            xAxisView.leftAnchor.constraint(equalTo: graphBarsView.leftAnchor),
        ])
    }
}

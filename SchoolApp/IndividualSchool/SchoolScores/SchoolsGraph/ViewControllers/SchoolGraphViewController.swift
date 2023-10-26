//
//  TestGraph.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/7/22.
//

import Foundation
import UIKit

class SchoolGraphViewController: UIViewController {

    private let schoolColor: UIColor
    private let viewModel: SchoolViewModel

    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        self.schoolColor = viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro)
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var stackView: SchoolAppStackView = {
        let stackView = SchoolAppStackView(type: .vertical)
        return stackView
    }()
    
    lazy var schoolNameLabel: SchoolAppLabel = {
        let label = SchoolAppLabel(labelText: viewModel.schoolData.school.school_name, fontSize: .largeTitle)
        label.textColor = schoolColor
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 100.0)
        label.numberOfLines = 2
        return label
    }()

    lazy var middleStackView: SchoolAppStackView = {
        let stackView = SchoolAppStackView(type: .horizontal)
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var yAxisView: YAxisView = {
        let view = YAxisView()
        return view
    }()
    
    lazy var graphBarsView: GraphBarsView = {
        let view = GraphBarsView(satData: viewModel.schoolData.sat, schoolColor: schoolColor)
        return view
    }()
    
    lazy var xAxisView: XAxisView = {
        let view = XAxisView()
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        graphBarsView.animateBars()
    }
    
    private func layout() {
        view.addSubview(stackView)

        stackView.addSubview(schoolNameLabel)
        stackView.addSubview(middleStackView)
        middleStackView.addArrangedSubview(yAxisView)
        middleStackView.addArrangedSubview(graphBarsView)
        stackView.addSubview(xAxisView)
                
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            schoolNameLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            schoolNameLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.1),
            schoolNameLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9),
            schoolNameLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            
            middleStackView.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 10),
            middleStackView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            middleStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.7),
            middleStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            yAxisView.widthAnchor.constraint(equalTo: middleStackView.widthAnchor, multiplier: 0.1),
            
            xAxisView.topAnchor.constraint(equalTo: middleStackView.bottomAnchor, constant: 5),
            xAxisView.widthAnchor.constraint(equalTo: graphBarsView.widthAnchor),
            xAxisView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.05),
            xAxisView.leftAnchor.constraint(equalTo: graphBarsView.leftAnchor),
        ])
    }
}

//
//  TestGraph.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/7/22.
//

import Foundation
import UIKit

class TestGraphViewController: UIViewController {
    let score = UILabel()
    let scoreGraph = UILabel()
    let stackView = UIStackView()
    
    var testScore: Int
    var testName: String
    let graph: Float
    
    init(testScorez: String, name: String) {
        if testScorez != "Not Available" {
            testScore = Int(testScorez)!
            graph = Float(Double(testScore)/Double(550))
            print(graph)
        } else {
            testScore = 0
            graph = 0.0
        }
        testName = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style() {
        view.backgroundColor = .secondarySystemBackground
        
        score.translatesAutoresizingMaskIntoConstraints = false
        score.text = "\(testName): \(String(testScore))"
        score.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
        score.adjustsFontSizeToFitWidth = true
        score.textAlignment = .center
        
        scoreGraph.translatesAutoresizingMaskIntoConstraints = false
        scoreGraph.backgroundColor = .blue
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .lightGray
    }
    
    func layout() {
        view.addSubview(score)
        stackView.addSubview(scoreGraph)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            score.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            score.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: score.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scoreGraph.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            scoreGraph.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            scoreGraph.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: CGFloat(graph)),
            scoreGraph.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

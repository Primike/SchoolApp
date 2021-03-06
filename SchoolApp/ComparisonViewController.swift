//
//  ComparisonViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 8/2/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class ComparisonViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let screenStackView = UIStackView()
    let topStackView = UIStackView()
    var comparisonInfoView: ComparisonInfoView
    let comparisonInfoView2: ComparisonInfoView
    let verticalDivider = UILabel()
    let comparisonGraphView: ComparisonGraphView
    let map = MKMapView()

    
    var school: School
    var schoolScores: SchoolScores
    var school2: School
    var schoolScores2: SchoolScores
    var schoolColor = UIColor.systemBlue
    
    init(school1: School, scores1: SchoolScores, school2: School, scores2: SchoolScores) {
        self.school = school1
        self.schoolScores = scores1
        self.school2 = school2
        self.schoolScores2 = scores2
        
        self.comparisonInfoView = ComparisonInfoView(frame: CGRect(), school: school, schoolColor: .black)
        self.comparisonInfoView2 = ComparisonInfoView(frame: CGRect(), school: school2, schoolColor: .black)
        self.comparisonGraphView = ComparisonGraphView(frame: CGRect(), scores: scores1, scores2: scores2, schoolColor: schoolColor)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        setup()
    }
    
    func style() {
        view.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        screenStackView.translatesAutoresizingMaskIntoConstraints = false
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        comparisonInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        comparisonInfoView2.translatesAutoresizingMaskIntoConstraints = false
        
        verticalDivider.translatesAutoresizingMaskIntoConstraints = false
        verticalDivider.backgroundColor = .black
        
        comparisonGraphView.translatesAutoresizingMaskIntoConstraints = false

        map.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(screenStackView)

        screenStackView.addSubview(topStackView)
        screenStackView.addSubview(comparisonGraphView)
        screenStackView.addSubview(map)
        
        topStackView.addSubview(comparisonInfoView)
        topStackView.addSubview(verticalDivider)
        topStackView.addSubview(comparisonInfoView2)

        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            screenStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            screenStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            screenStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            screenStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            screenStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.5),
            screenStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            topStackView.topAnchor.constraint(equalTo: screenStackView.topAnchor),
            topStackView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.3),
            topStackView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor, multiplier: 0.9),
            topStackView.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
            
            comparisonInfoView.topAnchor.constraint(equalTo: topStackView.topAnchor),
            comparisonInfoView.leftAnchor.constraint(equalTo: topStackView.leftAnchor),
            comparisonInfoView.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            comparisonInfoView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.45),
            
            verticalDivider.topAnchor.constraint(equalTo: topStackView.topAnchor),
            verticalDivider.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            verticalDivider.widthAnchor.constraint(equalToConstant: 5),
            verticalDivider.centerXAnchor.constraint(equalTo: topStackView.centerXAnchor),
            
            comparisonInfoView2.topAnchor.constraint(equalTo: topStackView.topAnchor),
            comparisonInfoView2.rightAnchor.constraint(equalTo: topStackView.rightAnchor),
            comparisonInfoView2.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            comparisonInfoView2.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.45),
            
//            comparisonGraphView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            comparisonGraphView.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.3),
            comparisonGraphView.widthAnchor.constraint(equalTo: screenStackView.widthAnchor, multiplier: 0.9),
            comparisonGraphView.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
            comparisonGraphView.centerYAnchor.constraint(equalTo: screenStackView.centerYAnchor),
            
            map.bottomAnchor.constraint(equalTo: screenStackView.bottomAnchor, constant: -10),
            map.heightAnchor.constraint(equalTo: screenStackView.heightAnchor, multiplier: 0.3),
            map.widthAnchor.constraint(equalTo: screenStackView.widthAnchor, multiplier: 0.9),
            map.centerXAnchor.constraint(equalTo: screenStackView.centerXAnchor),
        ])
    }
    
    func setup() {
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.addMapPin(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude), label: "CURRENT LOCATION")
                strongSelf.addMapPin(latitude: self!.school.latitude!, longitude: self!.school.longitude!, label: self!.school.school_name)
                strongSelf.addMapPin(latitude: self!.school2.latitude!, longitude: self!.school2.longitude!, label: self!.school2.school_name)

                strongSelf.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
            }
        }
    }
    
    func addMapPin(latitude: String, longitude: String, label: String) {
        let pin = MKPointAnnotation()
        pin.coordinate.longitude = Double(longitude)!
        pin.coordinate.latitude = Double(latitude)!
        pin.title = label
        map.addAnnotation(pin)
    }
}

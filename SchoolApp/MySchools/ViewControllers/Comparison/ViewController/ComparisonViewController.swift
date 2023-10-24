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
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var screenStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()
    
    lazy var topStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView()
        return stackView
    }()

    lazy var verticalDivider: UILabel = {
        var divider = UILabel()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .black
        return divider
    }()
    
    lazy var map: MKMapView = {
        var map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
        return map
    }()
    
    var comparisonInfoView: ComparisonInfoView
    let comparisonInfoView2: ComparisonInfoView
    let comparisonGraphView: ComparisonGraphView

    var school1: SchoolData
    var school2: SchoolData
    var schoolColor = UIColor.systemBlue
    
    init(school1: SchoolData, school2: SchoolData) {
        self.school1 = school1
        self.school2 = school2
        
        self.comparisonInfoView = ComparisonInfoView(school: school1, color: .black)
        self.comparisonInfoView2 = ComparisonInfoView(school: school2, color: .brown)
        self.comparisonGraphView = ComparisonGraphView(school1: school1, school2: school2, schoolColor: schoolColor)
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
                
        comparisonInfoView.translatesAutoresizingMaskIntoConstraints = false
        if school1.sat.dbn != "0" {
            comparisonInfoView.testtakersLabel.text = "Test Takes: \(school1.sat.num_of_sat_test_takers)"
            comparisonInfoView.mathLabel.text = "Math Score: \(school1.sat.sat_math_avg_score)"
            comparisonInfoView.writingLabel.text = "Writing Score: \(school1.sat.sat_writing_avg_score)"
            comparisonInfoView.readingLabel.text = "Reading Score: \(school1.sat.sat_critical_reading_avg_score)"
        }
        
        comparisonInfoView2.translatesAutoresizingMaskIntoConstraints = false
        if school2.sat.dbn != "0" {
            comparisonInfoView2.testtakersLabel.text = "Test Takes: \(school2.sat.num_of_sat_test_takers)"
            comparisonInfoView2.mathLabel.text = "Math Score: \(school2.sat.sat_math_avg_score)"
            comparisonInfoView2.writingLabel.text = "Writing Score: \(school2.sat.sat_writing_avg_score)"
            comparisonInfoView2.readingLabel.text = "Reading Score: \(school2.sat.sat_critical_reading_avg_score)"
        }
        
        comparisonGraphView.translatesAutoresizingMaskIntoConstraints = false
        comparisonGraphView.legendView.school1Label.text = school1.school.school_name
        comparisonGraphView.legendView.school2Label.text = school2.school.school_name
                
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
            
            verticalDivider.heightAnchor.constraint(equalTo: topStackView.heightAnchor, multiplier: 0.9),
            verticalDivider.bottomAnchor.constraint(equalTo: topStackView.bottomAnchor),
            verticalDivider.widthAnchor.constraint(equalToConstant: 5),
            verticalDivider.centerXAnchor.constraint(equalTo: topStackView.centerXAnchor),
            
            comparisonInfoView2.topAnchor.constraint(equalTo: topStackView.topAnchor),
            comparisonInfoView2.rightAnchor.constraint(equalTo: topStackView.rightAnchor),
            comparisonInfoView2.heightAnchor.constraint(equalTo: topStackView.heightAnchor),
            comparisonInfoView2.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.45),
            
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
                strongSelf.addMapPin(latitude: self!.school1.school.latitude!, longitude: self!.school1.school.longitude!, label: self!.school1.school.school_name)
                strongSelf.addMapPin(latitude: self!.school2.school.latitude!, longitude: self!.school2.school.longitude!, label: self!.school2.school.school_name)

                strongSelf.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
                
                let loc = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                let distance1 = loc.distance(from: CLLocation(latitude: Double(self!.school1.school.latitude!) ?? 0.0, longitude: Double(self!.school1.school.longitude!) ?? 0.0))
                let distance2 = loc.distance(from: CLLocation(latitude: Double(self!.school2.school.latitude!) ?? 0.0, longitude: Double(self!.school2.school.longitude!) ?? 0.0))
                
                self!.comparisonInfoView.distanceLabel.text = "Distance: \(round(distance1/1609.34 * 100) / 100.0) miles"
                self!.comparisonInfoView2.distanceLabel.text = "Distance: \(round(distance2/1609.34 * 100) / 100.0) miles"
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

extension ComparisonViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
         let reuseIdentifier = "annotationView"
         var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
         if #available(iOS 11.0, *) {
             if view == nil {
                 view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
             }
             view?.displayPriority = .required
         } else {
             if view == nil {
                 view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
             }
         }
         view?.annotation = annotation
         view?.canShowCallout = true
         return view
     }
}

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
    
    var school1: SchoolData
    var school2: SchoolData
    
    init(school1: SchoolData, school2: SchoolData) {
        self.school1 = school1
        self.school2 = school2
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        return stackView
    }()
    
    lazy var infoStackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .horizontal)
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var infoView1: ComparisonInfoView = {
        var view = ComparisonInfoView(schoolData: school1, color: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var infoView2: ComparisonInfoView = {
        var view = ComparisonInfoView(schoolData: school2, color: .brown)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var verticalDivider: UIView = {
        var divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .black
        return divider
    }()
    
    lazy var graphView: ComparisonGraphView = {
        var graph = ComparisonGraphView(school1: school1, school2: school2)
        graph.translatesAutoresizingMaskIntoConstraints = false
        return graph
    }()
    
    lazy var map: MKMapView = {
        var map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
        return map
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        setup()
    }
    
    private func style() {
        view.backgroundColor = .white
                
        if school1.sat.dbn != "0" {
            infoView1.testtakersLabel.text = "Test Takes: \(school1.sat.num_of_sat_test_takers)"
            infoView1.mathLabel.text = "Math Score: \(school1.sat.sat_math_avg_score)"
            infoView1.writingLabel.text = "Writing Score: \(school1.sat.sat_writing_avg_score)"
            infoView1.readingLabel.text = "Reading Score: \(school1.sat.sat_critical_reading_avg_score)"
        }
        
        if school2.sat.dbn != "0" {
            infoView2.testtakersLabel.text = "Test Takes: \(school2.sat.num_of_sat_test_takers)"
            infoView2.mathLabel.text = "Math Score: \(school2.sat.sat_math_avg_score)"
            infoView2.writingLabel.text = "Writing Score: \(school2.sat.sat_writing_avg_score)"
            infoView2.readingLabel.text = "Reading Score: \(school2.sat.sat_critical_reading_avg_score)"
        }
    }
        
    private func setup() {
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
                
                self!.infoView1.distanceLabel.text = "Distance: \(round(distance1/1609.34 * 100) / 100.0) miles"
                self!.infoView2.distanceLabel.text = "Distance: \(round(distance2/1609.34 * 100) / 100.0) miles"
            }
        }
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addSubview(infoStackView)
        stackView.addSubview(graphView)
        stackView.addSubview(map)
        
        infoStackView.addArrangedSubview(infoView1)
        infoStackView.addArrangedSubview(verticalDivider)
        infoStackView.addArrangedSubview(infoView2)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.5),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10),
            infoStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3),
            infoStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9),
            infoStackView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            
            infoView1.widthAnchor.constraint(equalTo: infoView2.widthAnchor, multiplier: 1),
            verticalDivider.widthAnchor.constraint(equalToConstant: 5),
            
            graphView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3),
            graphView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9),
            graphView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            graphView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            
            map.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10),
            map.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3),
            map.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9),
            map.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
        ])
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

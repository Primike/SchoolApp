//
//  SchoolMapViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/18/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation


class SchoolMapViewController: UIViewController, Coordinated {
    
    private let viewModel: SchoolViewModel
    weak var coordinator: Coordinating?

    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: SchoolAppLabel = {
        let label = SchoolAppLabel(labelText: "\(viewModel.school.school_name) Map", labelTextColor: viewModel.getColor(schoolBoro: viewModel.school.boro))
        return label
    }()
    
    lazy var map: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
        map.showsUserLocation = true
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setup()
        layout()
    }
        
    private func setup() {
        guard let coordinate = viewModel.coordinate else { return }
        
        addMapPin(coordinate: coordinate, label: viewModel.school.school_name)
        
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
    }

    private func addMapPin(coordinate: CLLocationCoordinate2D, label: String) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = label
        map.addAnnotation(pin)
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(map)
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            map.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            map.widthAnchor.constraint(equalTo: view.widthAnchor),
            map.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
        ])
    }
}

extension SchoolMapViewController: MKMapViewDelegate {
    //MARK: Called to setup each annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //MARK: Ensure that the location annotation uses a default blue dot
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseIdentifier = "annotationView"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        
        configureAnnotationView(view, for: annotation)
        
        return view
    }
    
    private func configureAnnotationView(_ view: MKAnnotationView?, for annotation: MKAnnotation) {
        view?.annotation = annotation
        view?.canShowCallout = true
        view?.displayPriority = .required
    }
}

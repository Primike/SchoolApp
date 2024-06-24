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
    
    weak var coordinator: Coordinating?
    private let viewModel: SchoolViewModel

    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var stackView: SchoolAppStackView = {
        var stackView = SchoolAppStackView(type: .vertical)
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var titleLabel: SchoolAppLabel = {
        let label = SchoolAppLabel(labelText: "\(viewModel.schoolData.school.school_name) Map", fontSize: .largeTitle)
        label.textColor = viewModel.getColor(schoolBoro: viewModel.schoolData.school.boro)
        label.numberOfLines = 2
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
        
        LocationManager.shared.getUserLocation { [weak self] location in
            self?.centerMapOnUserLocation(location: location)
        }
    }
        
    // MARK: - Adds Pin For School Location
    private func setup() {
        guard let coordinate = viewModel.coordinates else { return }
        
        addMapPin(coordinate: coordinate, label: viewModel.schoolData.school.school_name)
        
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
    }

    private func addMapPin(coordinate: CLLocationCoordinate2D, label: String) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = label
        map.addAnnotation(pin)
    }
    
    private func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(map)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
        ])
    }
    
    private func centerMapOnUserLocation(location: CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        map.setRegion(region, animated: true)
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

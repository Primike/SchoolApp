//
//  MapSearchViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 10/15/23.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapSearchViewController: UIViewController, MapFilterDelegate {
    
    weak var coordinator: MapSearchCoordinator?
    private var viewModel: MapSearchViewModeling
    
    init(viewModel: MapSearchViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var map: MKMapView = {
        var map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
        map.showsUserLocation = true
        return map
    }()
    
    lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent { coordinator?.didFinish() }
    }

    // MARK: - Gets User Location And Centers The Initial Map View Accordingly
    private func setup() {
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.title = "Map Search"

        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let self = self else { return }
                                             
                self.viewModel.currentCoordinates = location.coordinate
                self.setupMap(coordinates: location.coordinate)
                self.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.04)), animated: true)
            }
        }
    }
    
    private func setupMap(coordinates: CLLocationCoordinate2D) {
        viewModel.filterByCoordinates(coordinates: coordinates, miles: 1)
        map.addAnnotations(viewModel.getPins())
    }
    
    private func layout() {
        view.addSubview(map)
        
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            map.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
        
    // MARK: - Called When Apply Button Clicked In Filter VC. Reloads The Maps Annotations
    func filterApplied(miles: Float, coordinates: CLLocationCoordinate2D) {
        map.removeAnnotations(map.annotations)
        map.addAnnotations(viewModel.getPins())
        self.map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude), span: MKCoordinateSpan(latitudeDelta: 0.02 * Double(miles), longitudeDelta: 0.03 * Double(miles))), animated: true)
        
        let addressPin = MKPointAnnotation()
        addressPin.coordinate = coordinates
        addressPin.title = "CURRENT ADDRESS"
        
        map.addAnnotation(addressPin)
    }

    @objc func filterTapped() {
        coordinator?.goToFilterView(viewController: self)
    }
}

extension MapSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let title = view.annotation?.title ?? ""
        
        guard let schoolData = viewModel.getSchoolData(name: title ?? "") else { return }
        
        coordinator?.goToSchoolView(schoolData: schoolData)
    }
    
    // MARK: - Called to setup each annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // MARK: Ensure that the location annotation uses a default blue dot
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseIdentifier = "annotationView"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKMarkerAnnotationView
        
        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        
        if annotation.title == "CURRENT ADDRESS" {
            view?.markerTintColor = .blue
        } else {
            view?.markerTintColor = .red
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

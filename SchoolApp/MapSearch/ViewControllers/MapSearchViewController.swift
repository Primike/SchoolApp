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

class MapSearchViewController: UIViewController {
    
    let viewModel: MapSearchViewModel
    weak var coordinator: MapSearchCoordinator?

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        view.backgroundColor = .systemBackground
    }
    
    private func setup() {
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let self = self else { return }
                                                
                self.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.04)), animated: true)
                self.viewModel.latitude = location.coordinate.latitude
                self.viewModel.longitude = location.coordinate.longitude
                self.setupMap()
            }
        }
    }
    
    private func layout() {
        view.addSubview(map)
        
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            map.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupMap() {
        viewModel.miles = 1
        viewModel.getSchoolsByMiles()
        map.addAnnotations(viewModel.getPins())
    }
}

extension MapSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let index = viewModel.getSchool(name: view.annotation!.title!!)

        coordinator?.goToSchoolView(school: viewModel.nearbySchools[index], schoolScores: viewModel.getSATScores(index: index))
    }
    
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

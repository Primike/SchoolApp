//
//  AddressSearchViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/17/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class AddressSearchViewController: UIViewController {
    
    let viewModel: MapSearchViewModel
    weak var coordinator: MapSearchCoordinator?
    var annotations = [MKPointAnnotation]()
    var location = CLLocation()
    var latitude = 0.0
    var longitude = 0.0
        
    init(viewModel: MapSearchViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var addressSearchHeaderView: AddressSearchHeaderView = {
        var view = AddressSearchHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemBlue
        return view
    }()
    
    lazy var map: MKMapView = {
        var map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    lazy var radiusText: SchoolAppTextField = {
        var textField = SchoolAppTextField()
        textField.delegate = self
        return textField
    }()
    
    lazy var addressText: SchoolAppTextField = {
        var textField = SchoolAppTextField()
        textField.delegate = self
        return textField
    }()
    
    lazy var enterButton: SchoolAppButton = {
        let button = SchoolAppButton(title: "Search", viewWidth: view.bounds.width, imageName: "magnifyingglass", titleSize: 42, imageSize: 42)
        button.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setup()
        layout()
    }
    
    func setup() {
        map.delegate = self
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                
                self.location = location

                self.addMapPin(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude), label: "CURRENT LOCATION")
                self.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)), animated: true)
                
                self.viewModel.latitude = location.coordinate.latitude
                self.viewModel.longitude = location.coordinate.longitude
                self.viewModel.addressSearch()
                self.setupMap()
            }
        }
    }

    func setupMap() {
        for school in viewModel.nearbySchools {
            guard let latitude = school.latitude, let longitude = school.longitude else { continue }
            addMapPin(latitude: latitude, longitude: longitude, label: school.school_name)
        }
        map.addAnnotations(annotations)
    }

    func addMapPin(latitude: String, longitude: String, label: String) {
        guard let lat = Double(latitude), let long = Double(longitude) else { return }
        
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        pin.title = label

        annotations.append(pin)
    }

    func layout() {
        view.addSubview(addressSearchHeaderView)
        view.addSubview(map)
        
        addressSearchHeaderView.schoolNumberStackView.addSubview(radiusText)
        addressSearchHeaderView.addressStackView.addSubview(addressText)
        addressSearchHeaderView.addressStackView.addSubview(enterButton)
        
        NSLayoutConstraint.activate([
            addressSearchHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addressSearchHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            addressSearchHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            addressSearchHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            radiusText.leftAnchor.constraint(equalTo: addressText.leftAnchor),
            radiusText.heightAnchor.constraint(equalTo: addressSearchHeaderView.schoolNumberStackView.heightAnchor),
            radiusText.widthAnchor.constraint(equalTo: addressSearchHeaderView.schoolNumberStackView.widthAnchor, multiplier: 0.3),
            radiusText.centerYAnchor.constraint(equalTo: addressSearchHeaderView.schoolNumberStackView.centerYAnchor),
            
            addressText.heightAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.heightAnchor, multiplier: 0.7),
            addressText.widthAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.widthAnchor, multiplier: 0.5),
            addressText.centerXAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.centerXAnchor),
            addressText.centerYAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.centerYAnchor),
            
            enterButton.rightAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.rightAnchor),
            enterButton.heightAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.heightAnchor, multiplier: 0.7),
            enterButton.widthAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.widthAnchor, multiplier: 0.23),
            enterButton.centerYAnchor.constraint(equalTo: addressSearchHeaderView.addressStackView.centerYAnchor),
            
            map.topAnchor.constraint(equalTo: addressSearchHeaderView.bottomAnchor),
            map.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension AddressSearchViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        addressSearchHeaderView.errorLabel.isHidden = true

        //MARK: Incase textfield is not properly initialized or connected
        guard let addressText = addressText.text, let radiusText = radiusText.text else { return }

        do {
            try viewModel.validateInput(addressText: addressText, radiusText: radiusText)
        } catch let error as InputError {
            errorHandler(message: error.localizedDescription)
            return
        } catch {
            errorHandler(message: "Unexpected error: \(error.localizedDescription)")
            return
        }

        //integer value and addresss check
        viewModel.geocode(address: addressText, radiusText: radiusText) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let coordinates):
                self.map.removeAnnotations(self.annotations)
                self.annotations = []
                
                self.addMapPin(latitude: String(coordinates.latitude), longitude: String(coordinates.longitude), label: "CURRENT LOCATION")
                self.map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)), animated: true)
                
                self.setupMap()

            case .failure(let error):
                errorHandler(message: error.localizedDescription)
            }
        }
        
        func errorHandler(message: String){
            addressSearchHeaderView.errorLabel.isHidden = false
            addressSearchHeaderView.errorLabel.text = message
        }
    }
}

extension AddressSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation?.title != "CURRENT LOCATION" {
            let index = viewModel.getSchool(name: view.annotation!.title!!)
            
            coordinator?.goToSchoolView(school: viewModel.nearbySchools[index], schoolScores: viewModel.getSATScores(index: index))
        }
    }
    
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

extension AddressSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addressText.endEditing(true)
        addressSearchHeaderView.errorLabel.isHidden = true
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        addressSearchHeaderView.errorLabel.isHidden = true
    }
}

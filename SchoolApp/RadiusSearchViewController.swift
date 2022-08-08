//
//  RadiusSearchViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/24/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class RadiusSearchViewController: UIViewController {
    
    let radiusSearchHeaderView = RadiusSearchHeaderView()
    let map = MKMapView()
    let milesText = UITextField()
    let enterButton = UIButton()

    let nearbySchoolsViewModel: MapSearchViewModel
    var nearbySchools = [School]()
    var annotations = [MKPointAnnotation]()
    var location = CLLocation()
        
    init(viewModel: MapSearchViewModel) {
        self.nearbySchoolsViewModel = viewModel
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
        map.translatesAutoresizingMaskIntoConstraints = false
        
        radiusSearchHeaderView.translatesAutoresizingMaskIntoConstraints = false
        radiusSearchHeaderView.backgroundColor = UIColor.systemBlue
        
        milesText.translatesAutoresizingMaskIntoConstraints = false
        milesText.font = UIFont(name:"HelveticaNeue", size: 20.0)
        milesText.adjustsFontSizeToFitWidth = true
        milesText.textAlignment = .center
        milesText.layer.borderWidth = 3
        milesText.layer.cornerRadius = 7.0
        milesText.textColor = .black
        milesText.delegate = self
        milesText.backgroundColor = .white
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        enterButton.setTitle("Find", for: .normal)
        enterButton.configuration = .filled()
        enterButton.configuration?.baseBackgroundColor = .black
    }
    
    func layout() {
        view.addSubview(radiusSearchHeaderView)
        view.addSubview(map)
        
        radiusSearchHeaderView.inputStackView.addSubview(milesText)
        radiusSearchHeaderView.buttonStackView.addSubview(enterButton)
        
        NSLayoutConstraint.activate([
            radiusSearchHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            radiusSearchHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            radiusSearchHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            radiusSearchHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            map.topAnchor.constraint(equalTo: radiusSearchHeaderView.bottomAnchor),
            map.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            milesText.heightAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.heightAnchor, multiplier: 0.7),
            milesText.widthAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.widthAnchor, multiplier: 0.3),
            milesText.centerXAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.centerXAnchor),
            milesText.centerYAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.centerYAnchor),
            
            enterButton.heightAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.heightAnchor, multiplier: 0.7),
            enterButton.widthAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.widthAnchor),
            enterButton.centerYAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.centerYAnchor),
            enterButton.centerXAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.centerXAnchor),
        ])
    }

    func setup() {
        map.delegate = self
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                self!.location = location
                
                strongSelf.addMapPin(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude), label: "CURRENT LOCATION")
                let x = 0.5
                strongSelf.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02*x, longitudeDelta: 0.04*x)), animated: true)
                
                self!.nearbySchoolsViewModel.latitude = location.coordinate.latitude
                self!.nearbySchoolsViewModel.longitude = location.coordinate.longitude
                self!.nearbySchoolsViewModel.getSchoolsByMiles()
                self!.setupMap()
            }
        }
    }
    
    func setupMap() {
        for i in nearbySchoolsViewModel.nearbySchools {
            addMapPin(latitude: i.latitude!, longitude: i.longitude!, label: i.school_name)
        }
        map.addAnnotations(annotations)
    }
    
    func addMapPin(latitude: String, longitude: String, label: String) {
        let pin = MKPointAnnotation()
        pin.coordinate.longitude = Double(longitude)!
        pin.coordinate.latitude = Double(latitude)!
        pin.title = label
        
        annotations.append(pin)
    }
}

extension RadiusSearchViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        radiusSearchHeaderView.errorLabel.isHidden = true

        if milesText.text!.isEmpty{
            return
        }
        
        if Double(milesText.text!) == nil{
            errorHandler(message: "Please Enter A Numerical Value")
            return
        }
        
        if Double(milesText.text!)! > 50 {
            errorHandler(message: "Please Type In A Value Less Than 50")
            return
        }
        
        if Double(milesText.text!) != nil{

            self.nearbySchoolsViewModel.miles = Double(milesText.text!)!
            self.nearbySchoolsViewModel.getSchoolsByMiles()
            self.map.removeAnnotations(annotations)
            self.annotations = []
            self.setup()
            //fix this
            self.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        }

        func errorHandler(message: String){
            radiusSearchHeaderView.errorLabel.isHidden = false
            radiusSearchHeaderView.errorLabel.text = message
        }
    }
}

extension RadiusSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation?.title != "CURRENT LOCATION" {
            let index = nearbySchoolsViewModel.findSchool(name: view.annotation!.title!!)
            
            navigationController?.present(SchoolTabBarViewController(school: nearbySchoolsViewModel.nearbySchools[index], scores: nearbySchoolsViewModel.findSchoolScores(index: index)), animated: true)
        }
    }
}

extension RadiusSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        milesText.endEditing(true)
        radiusSearchHeaderView.errorLabel.isHidden = true
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        radiusSearchHeaderView.errorLabel.isHidden = true
    }
}

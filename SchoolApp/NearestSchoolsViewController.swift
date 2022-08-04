//
//  NearestSchoolsViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/25/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class NearbySchoolsViewController: UIViewController {
    
    let nearbySchoolsHeaderView = NearbySchoolsHeaderView()
    let map = MKMapView()
    let schoolsNumber = UITextField()
    let enterButton = UIButton()

    let nearbySchoolsViewModel: MapSearchViewModel
    var annotations = [MKPointAnnotation]()
        
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
        
        nearbySchoolsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        nearbySchoolsHeaderView.backgroundColor = UIColor.systemBlue
        
        schoolsNumber.translatesAutoresizingMaskIntoConstraints = false
        schoolsNumber.font = UIFont(name:"HelveticaNeue", size: 20.0)
        schoolsNumber.adjustsFontSizeToFitWidth = true
        schoolsNumber.textAlignment = .center
        schoolsNumber.layer.borderWidth = 3
        schoolsNumber.layer.cornerRadius = 7.0
        schoolsNumber.textColor = .black
        schoolsNumber.delegate = self
        schoolsNumber.backgroundColor = .white
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        enterButton.setTitle("Find", for: .normal)
        enterButton.configuration = .filled()
        enterButton.configuration?.baseBackgroundColor = .black
    }
    
    func layout() {
        view.addSubview(nearbySchoolsHeaderView)
        view.addSubview(map)
        
        nearbySchoolsHeaderView.inputStackView.addSubview(schoolsNumber)
        nearbySchoolsHeaderView.buttonStackView.addSubview(enterButton)
        
        NSLayoutConstraint.activate([
            nearbySchoolsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nearbySchoolsHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            nearbySchoolsHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            nearbySchoolsHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            map.topAnchor.constraint(equalTo: nearbySchoolsHeaderView.bottomAnchor),
            map.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            schoolsNumber.heightAnchor.constraint(equalTo: nearbySchoolsHeaderView.inputStackView.heightAnchor, multiplier: 0.7),
            schoolsNumber.widthAnchor.constraint(equalTo: nearbySchoolsHeaderView.inputStackView.widthAnchor, multiplier: 0.3),
            schoolsNumber.centerXAnchor.constraint(equalTo: nearbySchoolsHeaderView.inputStackView.centerXAnchor),
            schoolsNumber.centerYAnchor.constraint(equalTo: nearbySchoolsHeaderView.inputStackView.centerYAnchor),
            
            enterButton.heightAnchor.constraint(equalTo: nearbySchoolsHeaderView.buttonStackView.heightAnchor, multiplier: 0.7),
            enterButton.widthAnchor.constraint(equalTo: nearbySchoolsHeaderView.buttonStackView.widthAnchor),
            enterButton.centerYAnchor.constraint(equalTo: nearbySchoolsHeaderView.buttonStackView.centerYAnchor),
            enterButton.centerXAnchor.constraint(equalTo: nearbySchoolsHeaderView.buttonStackView.centerXAnchor),
        ])
    }

    func setup() {
        map.delegate = self
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.addMapPin(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude), label: "CURRENT LOCATION")
                strongSelf.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
                
                self!.nearbySchoolsViewModel.latitude = location.coordinate.latitude
                self!.nearbySchoolsViewModel.longitude = location.coordinate.longitude
                self!.nearbySchoolsViewModel.getNearbySchools()
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

extension NearbySchoolsViewController {
    @objc func enterButtonTapped(sender: UIButton) {
        
        nearbySchoolsHeaderView.errorLabel.isHidden = true

        if schoolsNumber.text!.isEmpty{
            return
        }
        
        if Int(schoolsNumber.text!) == nil{
            errorHandler(message: "Please Enter An Integer Value")
            return
        }
        
        if Int(schoolsNumber.text!)! > nearbySchoolsViewModel.schools.count {
            errorHandler(message: "Please Type In A Value Less Than \(nearbySchoolsViewModel.schools.count)")
            return
        }
        
        if Int(schoolsNumber.text!) != nil{

            self.nearbySchoolsViewModel.number = Int(schoolsNumber.text!)!
            self.nearbySchoolsViewModel.getNearbySchools()
            self.map.removeAnnotations(annotations)
            self.annotations = []
            self.setup()
        }

        func errorHandler(message: String){
            nearbySchoolsHeaderView.errorLabel.isHidden = false
            nearbySchoolsHeaderView.errorLabel.text = message
        }
    }
}

extension NearbySchoolsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation?.title != "CURRENT LOCATION" {
            let index = nearbySchoolsViewModel.findSchool(name: view.annotation!.title!!)
            
            navigationController?.present(SchoolTabBarViewController(school: nearbySchoolsViewModel.nearbySchools[index], scores: nearbySchoolsViewModel.findSchoolScores(index: index)), animated: true)
        }
    }
}

extension NearbySchoolsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        schoolsNumber.endEditing(true)
        nearbySchoolsHeaderView.errorLabel.isHidden = true
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nearbySchoolsHeaderView.errorLabel.isHidden = true
    }
}


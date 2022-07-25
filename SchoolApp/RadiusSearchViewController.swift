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
    
    let map = MKMapView()
    let milesText = UITextField()
    let enterButton = UIButton()

    let nearbySchoolsViewModel: NearbySchoolsViewModel
    var nearbySchools = [School]()
    var annotations = [MKPointAnnotation]()
    
    let radiusSearchHeaderView = RadiusSearchHeaderView()
    
    init(viewModel: NearbySchoolsViewModel) {
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
        radiusSearchHeaderView.layer.cornerRadius = 30
        radiusSearchHeaderView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        radiusSearchHeaderView.backgroundColor = UIColor.systemBlue
        
        milesText.translatesAutoresizingMaskIntoConstraints = false
        milesText.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        milesText.font = UIFont(name:"HelveticaNeue", size: 40.0)
        milesText.adjustsFontSizeToFitWidth = true
        milesText.textAlignment = .center
        milesText.layer.borderWidth = 3
        milesText.layer.cornerRadius = 7.0
        milesText.textColor = .white
        milesText.delegate = self
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .primaryActionTriggered)
        enterButton.backgroundColor = .black
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.setTitle("Search", for: .normal)
        enterButton.titleLabel!.font = UIFont(name:"HelveticaNeue-bold", size: 20.0)
        enterButton.titleLabel!.adjustsFontSizeToFitWidth = true
        enterButton.layer.cornerRadius = 10
        enterButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func layout() {
        view.addSubview(radiusSearchHeaderView)
        view.addSubview(map)
        
        radiusSearchHeaderView.inputStackView.addSubview(milesText)
        radiusSearchHeaderView.buttonStackView.addSubview(enterButton)
        
        NSLayoutConstraint.activate([
            radiusSearchHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            radiusSearchHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            radiusSearchHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            map.topAnchor.constraint(equalTo: radiusSearchHeaderView.bottomAnchor),
            map.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            milesText.heightAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.heightAnchor, multiplier: 0.7),
            milesText.widthAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.widthAnchor, multiplier: 0.3),
            milesText.centerXAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.centerXAnchor),
            milesText.centerYAnchor.constraint(equalTo: radiusSearchHeaderView.inputStackView.centerYAnchor),
            
            enterButton.centerYAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.centerYAnchor),
            enterButton.centerXAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.centerXAnchor),
            enterButton.heightAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.heightAnchor, multiplier: 0.7),
            enterButton.widthAnchor.constraint(equalTo: radiusSearchHeaderView.buttonStackView.widthAnchor, multiplier: 0.8),
        
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
                strongSelf.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)), animated: true)
                
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
            errorHandler(message: "Please Enter An Integer Value")
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

        }

        func errorHandler(message: String){
            radiusSearchHeaderView.errorLabel.isHidden = false
            radiusSearchHeaderView.errorLabel.text = message
        }
    }
}

extension RadiusSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let index = nearbySchoolsViewModel.findSchool(name: view.annotation!.title!!)
        
        navigationController?.pushViewController(SchoolTabBarViewController(school: nearbySchoolsViewModel.nearbySchools[index], scores: nearbySchoolsViewModel.findSchoolScores(index: index)), animated: true)
        
    }
}

extension RadiusSearchViewController: UITextFieldDelegate {
    //the user hits return, so we should end editing and return true
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        milesText.endEditing(true)
        radiusSearchHeaderView.errorLabel.isHidden = true
        return true
    }
    
    //callback to see what's in the text field
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        radiusSearchHeaderView.errorLabel.isHidden = true
    }
}

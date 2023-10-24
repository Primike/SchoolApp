//
//  MapFilterViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 10/15/23.
//

import Foundation
import UIKit
import MapKit

protocol MapFilterDelegate: AnyObject {
    func filterApplied(miles: Float, coordinates: CLLocationCoordinate2D)
}

class MapFilterViewController: UIViewController {
    
    let viewModel: MapSearchViewModel
    weak var coordinator: MapSearchCoordinator?
    weak var delegate: MapFilterDelegate?

    init(viewModel: MapSearchViewModel) {
        self.viewModel = viewModel
        
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

    lazy var mapFilterView: MapFilterView = {
        var view = MapFilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setup()
        layout()
    }
    
    var currentData: [Int] {
        switch mapFilterView.segmentedControl.selectedSegmentIndex {
        case 0:
            return [0, 600, 1000, 1400, 1800, 2000, 2200]
        default:
            return [0, 200, 300, 400, 500, 600, 700, 800]
        }
    }
    
    private func setup() {
        mapFilterView.milesSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        mapFilterView.numberPicker.dataSource = self
        mapFilterView.numberPicker.delegate = self
        mapFilterView.minScorePicker.dataSource = self
        mapFilterView.minScorePicker.delegate = self
        
        mapFilterView.applyButton.addTarget(self, action: #selector(applyTouched), for: .touchDown)
        mapFilterView.applyButton.addTarget(self, action: #selector(applyTapped), for: [.touchUpInside, .touchUpOutside])
        
        mapFilterView.segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)

    }
    
    private func layout() {
        view.addSubview(mapFilterView)
                
        NSLayoutConstraint.activate([
            mapFilterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mapFilterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapFilterView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75),
            mapFilterView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        mapFilterView.milesLabel.text = "\(Int(sender.value)) Miles"
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        mapFilterView.minScorePicker.reloadAllComponents()
    }

    @objc func applyTouched() {
        UIView.animate(withDuration: 0.1) {
            self.mapFilterView.applyButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }
    }

    @objc func applyTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            self.mapFilterView.applyButton.transform = CGAffineTransform.identity
        }

        let address = mapFilterView.addressText.text ?? ""
        let miles = mapFilterView.milesSlider.value
        let schoolIndex = mapFilterView.numberPicker.selectedRow(inComponent: 0) + 1
        let scoreIndex = mapFilterView.minScorePicker.selectedRow(inComponent: 0)
        let score = currentData[scoreIndex]
        let section = mapFilterView.segmentedControl.selectedSegmentIndex
        
        viewModel.validateAddress(address: address, radius: miles) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let coordinates):
                self.viewModel.filterByMiles(coordinates: coordinates, miles: Double(miles))
                self.viewModel.modifyDuplicates()
                self.viewModel.filterBySATData(selectedSegment: section, score: score, number: schoolIndex)
                self.delegate?.filterApplied(miles: miles, coordinates: coordinates)
                self.navigationController?.popViewController(animated: true)
                print(self.viewModel.nearbySchools.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension MapFilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == mapFilterView.numberPicker {
            return 30
        } else {
            return currentData.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let array = Array(1...30)
        if pickerView == mapFilterView.numberPicker {
            return String(array[row])
        } else {
            return String(currentData[row])
        }
    }
}

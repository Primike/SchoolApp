//
//  MapFilterViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 10/15/23.
//

import Foundation
import UIKit

class MapFilterViewController: UIViewController {
    
    let pickerData: [Int] = Array(1...10)
    let viewModel: MapSearchViewModel
    weak var coordinator: MapSearchCoordinator?

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
    
    private func setup() {
        mapFilterView.milesSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        mapFilterView.numberPicker.dataSource = self
        mapFilterView.numberPicker.delegate = self
        mapFilterView.minScorePicker.dataSource = self
        mapFilterView.minScorePicker.delegate = self
        mapFilterView.applyButton.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)
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
    
    @objc func applyTapped(sender: UIButton) {
        let address = mapFilterView.addressText.text ?? ""
        let miles = mapFilterView.milesSlider.value
        let schoolIndex = mapFilterView.numberPicker.selectedRow(inComponent: 0)
        let schools = pickerData[schoolIndex]
        let scoreIndex = mapFilterView.minScorePicker.selectedRow(inComponent: 0)
        let score = pickerData[scoreIndex]
        let section = mapFilterView.segmentedControl.selectedSegmentIndex
        print(section)
        
        self.coordinator?.navigationController.popViewController(animated: true)
    }
}

extension MapFilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
}

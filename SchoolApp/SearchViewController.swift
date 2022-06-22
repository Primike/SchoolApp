//
//  SearchViewController.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/21/22.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    let tableofResults = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Results"
        
    }
    
    func style() {
        
    }
    func layout() {
        
    }
    func setup() {
        tableofResults.delegate = self
        tableofResults.dataSource = self
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}

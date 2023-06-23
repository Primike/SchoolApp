//
//  School.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

import Foundation

struct School: Decodable {
    let dbn: String
    let school_name: String
    let boro: Borough
    let overview_paragraph: String
    var location: String
    let website: String
    let phone_number: String
    var mergedText: String?
    var latitude: String?
    var longitude: String?
    var distance: String?
    
    func lowercased() -> String {
        return school_name.lowercased()
    }
    func uppercased() -> String {
        return school_name.uppercased() 
    }
}

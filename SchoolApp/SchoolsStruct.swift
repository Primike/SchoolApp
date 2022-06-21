//
//  SchoolStructs.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

import Foundation

struct Schools: Decodable {
    let status: String
    let data: [School]
}

struct School: Decodable {
    let dbn: String
    let school_name: String
    let boro: String
    let overview_paragraph: String
    var location: String
    let website: String
    let phone_number: String
    let interest1: String
}

//struct Response: Decodable {
//    var users : [School]
//}

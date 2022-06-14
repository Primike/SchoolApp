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
    var dbn: String
    var school_name: String
    var overview_paragraph: String
    var location: String
    var website: String
    var boro: String
}

//struct Response: Decodable {
//    var users : [School]
//}

//
//  URLs.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

import Foundation
enum URLs {
    case schoolsURL
    case satDataURL
    case localSchoolsURL
    case localSATDataURL
    
    var value: URL? {
        switch self {
        case .schoolsURL:
            return URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
        case .satDataURL:
            return URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")
        case .localSchoolsURL:
            let path = Bundle.main.path(forResource: "SchoolsData", ofType: "json")
            
            return URL(fileURLWithPath: path ?? "")
        case .localSATDataURL:
            let path = Bundle.main.path(forResource: "SATData", ofType: "json")

            return URL(fileURLWithPath: path ?? "")
        }
    }
}

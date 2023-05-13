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
    
    var value: URL? {
        switch self {
        case .schoolsURL:
            return URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
        case .satDataURL:
            return URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")
        }
    }
}

enum LocalFilesPath: String {
    case schoolsPath = "SchoolsData"
    case satDataPath = "SATData"
}

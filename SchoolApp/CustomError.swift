//
//  CustomError.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/5/22.
//

import Foundation

enum CustomError {
    case noConnection, noSchoolData, noSATData
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noConnection:
            return "No Internet Connection"
        case .noSchoolData:
            return "Schools Data Unavailable"
        case .noSATData:
            return "SAT Data Unavailable"
        }
    }
}

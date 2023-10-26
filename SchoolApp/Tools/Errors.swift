//
//  CustomError.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/5/22.
//

import Foundation

enum CustomError: Error {
    case noConnection, noSchoolsData, noSATData, noLocalSchoolsData, noLocalSATData
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noConnection:
            return "No Internet Connection"
        case .noSchoolsData:
            return "Schools Data Unavailable"
        case .noSATData:
            return "SAT Data Unavailable"
        case .noLocalSchoolsData:
            return "Local School Data Error"
        case .noLocalSATData:
            return "Local SAT Data Error"
        }
    }
}

enum AlertErrors: String {
    case noConnection = "No Connection Using Local Data"
    case schoolDataError = "There Was A Problem With The School Data"
    case satDataError = "There Was A Problem With The SAT Data"
}

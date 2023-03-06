//
//  SATScores.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation

struct SATData: Decodable {
    var dbn = "0"
    var num_of_sat_test_takers = "Not Available"
    var sat_critical_reading_avg_score = "0"
    var sat_math_avg_score = "0"
    var sat_writing_avg_score = "0"
}

enum satSectionScores {
    case sat_critical_reading_avg_score
    case sat_math_avg_score
    case sat_writing_avg_score
}

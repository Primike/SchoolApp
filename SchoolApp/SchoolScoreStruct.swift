//
//  TestsStruct.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation

struct SchoolScores: Decodable {
    let dbn: String
    let num_of_sat_test_takers: String
    let sat_critical_reading_avg_score: String
    let sat_math_avg_score: String
    let sat_writing_avg_score: String

}

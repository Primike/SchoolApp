//
//  SATScores.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/6/22.
//

import Foundation

struct SATData: Decodable {
    var dbn: String
    var num_of_sat_test_takers: String
    var sat_critical_reading_avg_score: String
    var sat_math_avg_score: String
    var sat_writing_avg_score: String

    var totalScore: Int {
        let readingScore = Int(sat_critical_reading_avg_score) ?? 0
        let mathScore = Int(sat_math_avg_score) ?? 0
        let writingScore = Int(sat_writing_avg_score) ?? 0
        
        return readingScore + mathScore + writingScore
    }
    
//    enum CodingKeys: String, CodingKey {
//        case dbn
//        case num_of_sat_test_takers
//        case sat_critical_reading_avg_score
//        case sat_math_avg_score
//        case sat_writing_avg_score
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        dbn = (try? container.decode(String.self, forKey: .dbn)) ?? ""
//        num_of_sat_test_takers = (try? container.decode(String.self, forKey: .num_of_sat_test_takers)) ?? "Not Available"
//        sat_critical_reading_avg_score = (try? container.decode(String.self, forKey: .sat_critical_reading_avg_score)) ?? "0"
//        sat_math_avg_score = (try? container.decode(String.self, forKey: .sat_math_avg_score)) ?? "0"
//        sat_writing_avg_score = (try? container.decode(String.self, forKey: .sat_writing_avg_score)) ?? "0"
//    }

    init(dbn: String) {
        self.dbn = dbn
        self.num_of_sat_test_takers = "Not Available"
        self.sat_critical_reading_avg_score = "0"
        self.sat_math_avg_score = "0"
        self.sat_writing_avg_score = "0"
    }
}

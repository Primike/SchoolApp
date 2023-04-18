//
//  SchoolViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 4/18/23.
//

import Foundation
import UIKit

class SchoolViewModel: SchoolColor {
    var school: School
    var schoolScores: SATData

    init(school: School, scores: SATData) {
        self.school = school
        self.schoolScores = scores
    }

}

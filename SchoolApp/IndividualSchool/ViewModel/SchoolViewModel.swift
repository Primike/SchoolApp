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
    var satData: SATData

    init(school: School, satData: SATData) {
        self.school = school
        self.satData = satData
    }

}

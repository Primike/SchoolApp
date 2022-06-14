//
//  DataManipulation.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

import Foundation
import UIKit

extension SchoolListViewController {
    func findMinAndRemove(_ array1: inout [Int], _ array2: inout [Int]) -> Int{
        if array1[0] < array2[0] {
            return array1.remove(at: 0)
        }
        return array2.remove(at: 0)
    }
    
    func merge(_ array1: inout [Int], _ array2: inout [Int]) -> [Int] {
        var sorted = [Int]()
        var currentMin = 0
        while array1.count != 0 && array2.count != 0 {
            currentMin = findMinAndRemove(&array1, &array2)
            sorted.append(currentMin)
        }
        
        return sorted + array1 + array2
    }
    
    func sortSchools(_ array: [School]) {
        for i in array {
            print(i.school_name)
        }
    }
}

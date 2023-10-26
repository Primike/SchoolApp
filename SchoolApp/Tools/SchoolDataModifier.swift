//
//  SchoolDataModifier.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 10/24/23.
//

import Foundation
import CoreLocation

class SchoolDataModifier {
    
    // MARK: - Schools Modifier
    static func modifySchoolData(schools: [School]) -> [School] {
        return schools.map { data in
            var school = data

            if let index = school.location.firstIndex(of: "(") {
                school.location = String(school.location[..<index])
            }

            var text = school.school_name + school.location + getBorough(boro: school.boro)
            let charactersToRemove = Set(" ,.-():/")
            
            text = text.filter { !charactersToRemove.contains($0) }
            text = text.replacingOccurrences(of: "&", with: "and")
            school.mergedText = text

            if school.latitude == nil || school.longitude == nil {
                school.latitude = "0"
                school.longitude = "0"
            }

            return school
        }
    }
    
    static func getBorough(boro: Borough) -> String {
        switch boro {
        case .manhattan:
            return "manhattan"
        case .bronx:
            return "bronx"
        case .brooklyn:
            return "brooklyn"
        case .queens:
            return "queens"
        case .statenIsland:
            return "statenIsland"
        }
    }

    // MARK: - SAT Modifier
    static func modifySATData(satData: [SATData]) -> [SATData] {
        return satData.filter { satRecord in
            return Int(satRecord.sat_critical_reading_avg_score) != nil &&
                   Int(satRecord.sat_math_avg_score) != nil &&
                   Int(satRecord.sat_writing_avg_score) != nil
        }
    }
    
    // MARK: - Coordinates Filter
    static func filterByMiles(schoolsData: [SchoolData], coordinates: CLLocationCoordinate2D, miles: Double) -> [SchoolData] {
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        let distanceThreshold = miles * 1609.34 // Convert miles to meters
        
        return schoolsData.filter { data in
            let school = data.school
            let loc = CLLocation(latitude: Double(school.latitude!)!, longitude: Double(school.longitude!)!)
            let distance = loc.distance(from: CLLocation(latitude: latitude, longitude: longitude))
            return distance <= distanceThreshold
        }
    }
    
    static func filterByProximity(nearbySchools: [SchoolData], coordinates: CLLocationCoordinate2D) -> [SchoolData] {
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude

        return nearbySchools.sorted { data1, data2 in
            let coordinates1 = data1.school.coordinates
            let coordinates2 = data2.school.coordinates
            
            let distance1 = abs(latitude - coordinates1.latitude) + abs(longitude - coordinates1.longitude)
            let distance2 = abs(latitude - coordinates2.latitude) + abs(longitude - coordinates2.longitude)
            
            return distance1 < distance2
        }
    }

    static func modifyCoordinateDuplicates(nearbySchools: [SchoolData]) -> [SchoolData] {
        var nearbySchools = nearbySchools
        
        for i in 0..<nearbySchools.count {
            for j in 0..<nearbySchools.count {
                if i != j && nearbySchools[i].school.latitude == nearbySchools[j].school.latitude && nearbySchools[i].school.longitude == nearbySchools[j].school.longitude {
                    nearbySchools[j].school.longitude = "\(Double(nearbySchools[j].school.longitude!)! + 0.0007 - 0.00009 * Double(j))"
                }
            }
        }
        
        return nearbySchools
    }
    
    // MARK: - SAT Data Filter
    static func filterBySATData(nearbySchools: [SchoolData], selectedSegment: Int, score: String, count: String) -> [SchoolData] {
        let sections: [TopSchoolsCategory] = [.combined, .math, .reading, .writing]
        let category = sections[selectedSegment]
        var filtered = [SchoolData]()
        let score = Int(score) ?? 0
        
        for school in nearbySchools {
            switch category {
            case .math:
                if Int(school.sat.sat_math_avg_score) ?? 0 >= score { filtered.append(school) }
            case .reading:
                if Int(school.sat.sat_critical_reading_avg_score) ?? 0 >= score { filtered.append(school) }
            case .writing:
                if Int(school.sat.sat_writing_avg_score) ?? 0 >= score { filtered.append(school) }
            case .combined:
                let math = Int(school.sat.sat_math_avg_score) ?? 0
                let reading = Int(school.sat.sat_critical_reading_avg_score) ?? 0
                let writing = Int(school.sat.sat_writing_avg_score) ?? 0
                
                if math + reading + writing >= score { filtered.append(school) }
            }
        }
        
        if let number = Int(count) { filtered = Array(filtered.prefix(number)) }
        
        return filtered
    }
}

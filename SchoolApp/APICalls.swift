//
//  APICalls.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

//viewwilltransitionto

import Foundation

struct SchoolServiceURLs {
    static let schoolDataUrl = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    static let scoresDataUrl = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
}

class SchoolServiceAPI {
    
    static let shared = SchoolServiceAPI()

    func getSchoolsData(completion: @escaping (Result<[School], Error>) -> Void) {
        
        guard Reachability.isConnectedToNetwork(),
              let url = URL(string: "\(SchoolServiceURLs.schoolDataUrl)") else {
                  completion(.failure(CustomError.noConnection))
                  return
              }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(CustomError.noSchoolData))
                return
            }
            
            do {
                var results = try JSONDecoder().decode([School].self, from: data)
                for i in 0..<results.count {
                    if let index = results[i].location.firstIndex(of: "(") {
                        results[i].location = String(results[i].location[..<index])
                    }
                }
                
                for i in 0..<results.count {
                    var mergedText = results[i].school_name + results[i].location
                    let array = [" ", ",", ".", "-", "(", ")", ":", "/"]
                    for i in array {
                        mergedText = mergedText.replacingOccurrences(of: i, with: "")
                    }
                    mergedText = mergedText.replacingOccurrences(of: "&", with: "and")
                    results[i].mergedText = mergedText
                }
                
                for i in 0..<results.count {
                    if results[i].latitude == nil || results[i].longitude == nil{
                        results[i].latitude = "0"
                        results[i].longitude = "0"
                    }
                }
                completion(.success(results))
            } catch {
                completion(.failure(CustomError.noSchoolData))
            }
        }
        task.resume()
    }

    func getTestData(completion: @escaping (Result<[SchoolScores], Error>) -> Void) {
        
        guard Reachability.isConnectedToNetwork(),
              let url = URL(string: "\(SchoolServiceURLs.scoresDataUrl)") else {
                  completion(.failure(CustomError.noConnection))
                  return
              }
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(CustomError.noSATData))
                return
            }
            
            do {
                var results = try JSONDecoder().decode([SchoolScores].self, from: data)
                
                for i in 0..<results.count {
                    if Int(results[i].sat_critical_reading_avg_score) != nil && Int(results[i].sat_math_avg_score) != nil && Int(results[i].sat_writing_avg_score) != nil {
                    } else {
                        results[i] = SchoolScores()
                    }
                }
                
                completion(.success(results))
            } catch {
                completion(.failure(CustomError.noSATData))
            }
        }
        task.resume()
    }
}


//    let isDemo: Bool = true
//        if(isDemo){
//            //load local json
//        }else{
//            //api
//        }

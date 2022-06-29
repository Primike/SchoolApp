//
//  APICalls.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

//alert on api failure retry
//apicall
//viewwilltransitionto

import Foundation

struct SchoolServiceURLs {
    static let schoolDataUrl = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    static let scoresDataUrl = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
}

enum APIError: Error {
    case failedTogetData
}


class SchoolServiceAPI {
    static let shared = SchoolServiceAPI()
    
    func getSchoolsData(completion: @escaping (Result<[School], Error>) -> Void) {
        
        guard let url = URL(string: "\(SchoolServiceURLs.schoolDataUrl)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                var results = try JSONDecoder().decode([School].self, from: data)
                for i in 0..<results.count {
                    if let index = results[i].location.firstIndex(of: "(") {
                        results[i].location = String(results[i].location[..<index])
                    } else {
                        continue
                    }

                }
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    

    func getTestData(completion: @escaping (Result<[SchoolScores], Error>) -> Void) {
        
        guard let url = URL(string: "\(SchoolServiceURLs.scoresDataUrl)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode([SchoolScores].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}

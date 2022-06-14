//
//  APICalls.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

//mvvm
//next arrorw cells
//more info


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
    
    func getSchoolData(completion: @escaping (Result<[School], Error>) -> Void) {
        
        guard let url = URL(string: "\(SchoolServiceURLs.schoolDataUrl)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode([School].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    

    func getTestData(completion: @escaping (Result<[SchoolScore], Error>) -> Void) {
        
        guard let url = URL(string: "\(SchoolServiceURLs.scoresDataUrl)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode([SchoolScore].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}


//func getTestData(){
//
//    let task = URLSession.shared.dataTask(with: URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")!) { data, response, error in
//
//        if let data = data {
//            if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                as? [[String: Any]]) != nil {
//                do {
//                    self.schoolsSATData = try JSONDecoder().decode([SchoolScore].self, from: data)
//                } catch {
//                    print("ERROR")
//                }
//            }
//        }
//    }
//    task.resume()
//}


//
//
//extension SchoolListViewController {
//    func fetchSchoolAPI() {
//
//        var request = URLRequest(url: URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")!)
//
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { data, resp, error in
//            if error != nil {
//                print(error?.localizedDescription ?? "Error")
//            } else {
//                print("Success")
//            }
//
//            if let data = data {
//                if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    as? [[String: Any]]) != nil {
//                    self.schoolData = try! JSONDecoder().decode([School].self, from: data)
//                }
//            }
//            //leave DG
//        }.resume()
//    }
//    func fetchSchoolTestAPI() {
//
//        var request = URLRequest(url: URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")!)
//
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { data, resp, error in
//            if error != nil {
//                print(error?.localizedDescription ?? "Error")
//            } else {
//                print("Success")
//            }
//
//            if let data = data {
//                if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    as? [[String: Any]]) != nil {
//                    self.testData = try! JSONDecoder().decode([SchoolScore].self, from: data)
//                }
//            }
//        }.resume()
//    }
//}
//

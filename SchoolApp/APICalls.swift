//
//  APICalls.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 6/2/22.
//

//try error
//while delegate closure completion handlers
//mvvm
//next arrorw cells
//more info
//change button change


import Foundation


class SchoolServiceAPI {
    var schoolData = [School]()
    var schoolsSATData = [SchoolScore]()
    
    func getSchoolData() {
        
        let task = URLSession.shared.dataTask(with: URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")!) { data, response, error in
            
            if let data = data {
                if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    as? [[String: Any]]) != nil {
                    do {
                        self.schoolData = try JSONDecoder().decode([School].self, from: data)
                    } catch {
                        print("ERROR")
                    }
                }
            }
        }
        task.resume()
    }
    

    func getTestData(){
        
        let task = URLSession.shared.dataTask(with: URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")!) { data, response, error in
                        
            if let data = data {
                if (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    as? [[String: Any]]) != nil {
                    do {
                        self.schoolsSATData = try JSONDecoder().decode([SchoolScore].self, from: data)
                    } catch {
                        print("ERROR")
                    }
                }
            }
        }
        task.resume()
    }
}



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

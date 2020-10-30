//
//  Network.swift
//  Poor Billionaire
//
//  Created by Ulvi Bashirov on 10/21/20.
//

import Foundation
import UIKit
import Alamofire


struct Network {
    static let url = URL(string: "https://opentdb.com/api.php")!
    static let headers: HTTPHeaders = [.contentType("application/json")]
    
    static func request(diff: Difficulty, completion: @escaping (Result) -> ()) {
        let amount = 10
        let category = 9
        let type = "multiple"
        let difficulty = diff.rawValue
        
        let params: [String: String] = ["amount": String(amount), "category": String(category), "difficulty": difficulty, "type": type]
        
        AF.request(url, method: .get, parameters: params, headers: headers).responseJSON { response in
            if let jsonData = response.data {
                do {
                    let res = try JSONDecoder().decode(Result.self, from: jsonData)
                    completion(res)
                } catch let error {
                    print("request error: ", error.localizedDescription)
                }
            }
        }
    }
    
}


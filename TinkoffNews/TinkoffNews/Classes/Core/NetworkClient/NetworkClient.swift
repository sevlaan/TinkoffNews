//
//  NetworkClient.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 01.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case patch  = "PATCH"
    case delete = "DELETE"
}

class NetworkClient {
    
    func makeRequest(url: URL, httpMethod: HTTPMethod, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            completion(data, error)
        }
        
        dataTask.resume()
    }
}

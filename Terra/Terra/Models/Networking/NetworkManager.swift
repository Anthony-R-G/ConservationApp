//
//  NetworkManager.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/3/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

class NetworkManager {
    
    // MARK: - Static Properties
    
    static let shared = NetworkManager()
    
    // MARK: - Internal Properties
    
    func performDataTask(withUrl url: URL,
                         completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        
        let request = URLRequest(url: url)
        urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(.failure(.noDataReceived))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {
                    completion(.failure(.badStatusCode))
                    return
                }
                
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        completion(.failure(.noInternetConnection))
                        return
                    } else {
                        completion(.failure(.other(rawError: error)))
                        return
                    }
                }
                completion(.success(data))
            }
        }.resume()
    }
    
    // MARK: - Private Properties and Initializers
    
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    private init() {}
}

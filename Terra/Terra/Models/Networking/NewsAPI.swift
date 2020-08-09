//
//  NewsAPI.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/8/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import Combine

enum News {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "http://newsapi.org/v2/everything?q=animal+endangered+conservation+wildlife&sortBy=publishedAt&pageSize=20&page=1")!
}


extension News {
    
    static func request() -> AnyPublisher<NewsResponse, Error> {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/everything"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: Secrets.newsAPIKey),
            URLQueryItem(name: "q", value: "animals"),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "pageSize", value: "20"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        let request = URLRequest(url: urlComponents.url!.absoluteURL)
        print(request)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher() 
    }
}

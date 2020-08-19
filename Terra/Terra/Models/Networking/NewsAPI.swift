//
//  NewsAPI.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/8/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import Combine

enum NewsAPI {
    static let apiClient = APIClient()
}

extension NewsAPI {
    
    static func makeRequest(page: Int) -> AnyPublisher<NewsResponse, Error> {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/everything"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: Secrets.newsAPIKey),
            URLQueryItem(name: "q", value: "animal+endangered+conservation+wildlife"),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "pageSize", value: "20"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        let request = URLRequest(url: urlComponents.url!.absoluteURL)
 
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher() 
    }
}

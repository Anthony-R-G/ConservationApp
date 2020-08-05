//
//  NewsAPIClient.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/3/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

final class NewsAPIClient {
    private init() {}

    static let shared = NewsAPIClient()

    func fetchNewsData(completionHandler: @escaping (Result<[Article], NetworkError>) -> Void) {
        let urlStr = "http://newsapi.org/v2/everything?q=animal%20endangered%20conservation%20wildlife&sortBy=publishedAt&apiKey=\(Secrets.newsAPIKey)&pageSize=20&page=1"
      
         guard let url = URL(string: urlStr) else {
             completionHandler(.failure(.badURL))
             return
         }

         NetworkManager.shared.performDataTask(withUrl: url) { (result) in
             switch result {
             case .failure(let error) :
                 completionHandler(.failure(error))
                
             case .success(let data):
                 do {
                     let newsResultWrapper = try JSONDecoder().decode(NewsAPIResult.self, from: data)
                    completionHandler(.success(newsResultWrapper.articles))
                 } catch {
                     completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                 }
             }
         }
     }
}

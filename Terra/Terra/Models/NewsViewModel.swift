//
//  NewsViewModel.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/8/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import Combine

final class NewsViewModel: ObservableObject {
    @Published var newsArticles: [NewsArticle] = []
    
    func newsArticle(at index: Int) -> NewsArticle {
        return newsArticles[index]
    }
    
    var cancellationToken: AnyCancellable?
    
    init() {
        getNews()
    }
}

extension NewsViewModel {
    
    func getNews() {
        
        cancellationToken = News.request()
            .mapError({ (error) -> Error in 
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.newsArticles = $0.articles
            })
    }
}

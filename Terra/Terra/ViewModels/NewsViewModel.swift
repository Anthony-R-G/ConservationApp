//
//  NewsViewModel.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/8/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import Combine

final class NewsViewModel {
    //MARK: -- Properties
    
    private weak var delegate: NewsViewModelDelegate?
    
    private var cancellable: AnyCancellable?
    
    private var currentPage: Int = 1
    
    private var newsArticles: [NewsArticle] = []
    
    var filteredNewsArticles: [NewsArticle] {
        return filterDuplicateArticles(from: newsArticles)
    }
    
    private(set) var isFetchInProgress: Bool = false
    
    enum FetchType {
        case replace
        case append
    }

    //MARK: -- Methods
    
    private func filterDuplicateArticles(from news: [NewsArticle]) -> [NewsArticle] {
        var seenHeadlines = Set<String>()
        
        return news.compactMap { (newsArticle) in
            for title in newsArticle.cleanedUpTitle {
                guard !seenHeadlines.contains(title) else { return nil }
                
                seenHeadlines.insert(title)
                return newsArticle
            }
            
            return newsArticle
        }
    }
    
    func specificArticle(at index: Int) -> NewsArticle {
        return filteredNewsArticles[index]
    }
    
    init(delegate: NewsViewModelDelegate) {
        self.delegate = delegate
    }
}

extension NewsViewModel {
    
    func fetchNews(fetchType: FetchType) {
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        
        if fetchType == .replace {
            currentPage = 1
        } else {
            //News API has a dev plan cap of 100.
            guard currentPage < 5 else {
                isFetchInProgress = false
                delegate?.fetchCompleted()
                return
            }
            currentPage += 1
        }
        
        cancellable = NewsAPI.makeRequest(page: currentPage)
            .mapError({ [weak self] (error) -> Error in
                guard let self = self else { return error }
                print(error)
                self.isFetchInProgress = false
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    guard let articles = response.articles else { return }
                    switch fetchType {
                        
                    case .append:
                        self.newsArticles.append(contentsOf: articles)
                        
                    case .replace:
                        self.newsArticles = articles
                        self.currentPage = 1
                        
                    }
                    self.delegate?.fetchCompleted()
                    self.isFetchInProgress = false
            })
    }
}


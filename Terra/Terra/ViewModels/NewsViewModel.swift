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
    private var cancellationToken: AnyCancellable?
    
    private var newsArticles: [NewsArticle] = [] {
        didSet {
            delegate?.onFetchCompleted()
        }
    }
    
    private var filteredNewsArticles: [NewsArticle] {
        return filterDuplicateArticles(from: newsArticles)
    }
    
    private var currentPage: Int = 1
    private var isFetchInProgress = false
    
    var totalNewsArticlesCount: Int {
        return filteredNewsArticles.count
    }
    
    var newsFetchIsUnderway: Bool {
        return isFetchInProgress
    }
    
    
    //MARK: -- Methods
    private func filterDuplicateArticles(from news: [NewsArticle]) -> [NewsArticle] {
        var seenHeadlines = Set<String>()
        
        return newsArticles.compactMap { (newsArticle) in
            guard !seenHeadlines.contains(newsArticle.cleanedUpTitle)
                else { return nil }
            seenHeadlines.insert(newsArticle.cleanedUpTitle)
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
    
    func fetchNews() {
        
        isFetchInProgress = true
        
        cancellationToken = NewsAPI.request(page: currentPage.description)
            .mapError({ (error) -> Error in 
                print(error)
                self.isFetchInProgress = false
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in
                    self.newsArticles.append(contentsOf: response.articles)
                    self.currentPage += 1
                    self.isFetchInProgress = false
            })
    }
}



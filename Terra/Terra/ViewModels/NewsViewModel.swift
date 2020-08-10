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
    
    private var newsArticles: [NewsArticle] = []
    private var filteredNewsArticles: [NewsArticle] {
        return filterDuplicateArticles(from: newsArticles)
    }
    
    private var currentPage: Int = 1
    
    private var isFetchInProgress: Bool = false
    
    var totalNewsArticlesCount: Int {
        return filteredNewsArticles.count
    }
    
    var newsFetchIsUnderway: Bool {
        return isFetchInProgress
    }
    
    
    //MARK: -- Methods
    private func filterDuplicateArticles(from news: [NewsArticle]) -> [NewsArticle] {
        var seenHeadlines = Set<String>()
        
        return news.compactMap { (newsArticle) in
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
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
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
                    self.newsArticles.append(contentsOf: response.articles)
                    self.currentPage += 1
                    self.delegate?.fetchCompleted()
                    self.isFetchInProgress = false
            })
    }
}



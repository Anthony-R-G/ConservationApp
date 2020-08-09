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
    private var isFetchingNews = false
    
    var totalResultsCount: Int {
        return filteredNewsArticles.count
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
        cancellationToken = News.request()
            .mapError({ (error) -> Error in 
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] in
                    guard let self = self else { return }
                    self.newsArticles = $0.articles
            })
    }
}



//
//  NewsArticle.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/3/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct NewsArticle: Decodable, Hashable {
    let title: String
    let url: String
    let urlToImage: String?
    @ISO8601DateFormatted var publishedAt: String
    
    var cleanedUpTitle: String {
        get {
            title.removingNonAlphabetChars
        }
    }
}

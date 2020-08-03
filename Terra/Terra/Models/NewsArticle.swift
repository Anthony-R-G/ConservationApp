//
//  NewsArticle.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/3/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct NewsAPIResult: Codable {
    let articles: [Article]
}


struct Article: Codable {
    let title: String
    let url: String
    let urlToImage: String
}

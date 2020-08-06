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
    let totalResults: Int
}


struct Article: Codable {
    let title: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    
    var formattedPublishDate: String {
        get {
            
            let dateFormatter8601 = ISO8601DateFormatter()
            let timeAsConvertedFullDate = dateFormatter8601.date(from: publishedAt )!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
            return dateFormatter.string(from: timeAsConvertedFullDate)
        }
    }
}

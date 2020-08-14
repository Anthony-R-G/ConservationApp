//
//  ISO8601DateFormatted.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

@propertyWrapper
struct ISO8601DateFormatted: Hashable {
    private let formatter = ISO8601DateFormatter()
    private let value: String
    var wrappedValue: String {
        get {
            let timeAsConvertedFullDate = formatter.date(from: value)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
            return dateFormatter.string(from: timeAsConvertedFullDate)
        }
    }
}

extension ISO8601DateFormatted: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        value = string
    }
}

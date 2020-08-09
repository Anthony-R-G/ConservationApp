//
//  StringExtensions.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/2/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    var removingNonAlphabetChars: String {
        let characters = Set("abcdefghijklmnopqrstuvwxyz")
        var newStr = String()
        for char in self.lowercased() {
            if characters.contains(char) {
                newStr += String(char)
            }
        }
        return newStr
    }
}

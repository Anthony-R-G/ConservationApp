//
//  LearnMoreOverviewDescription.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct LearnMoreOverviewDescription: LearnMoreTextWindowStrategy {
    var species: Species
    
    func titleLabel() -> String {
        "DESCRIPTION"
    }
    
    func bodyText() -> String {
        species.overview.replacingOccurrences(of: "\\n", with: "\n")
    }
}

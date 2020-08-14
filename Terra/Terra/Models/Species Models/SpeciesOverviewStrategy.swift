//
//  SpeciesOverviewStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/31/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct SpeciesOverviewStrategy: SpeciesStrategy {
    var species: Species
    
    func titleText() -> String {
        return "OVERVIEW"
    }
    
    func barLeftTitleText() -> String {
        return "Height"
    }
    
    func barMiddleTitleText() -> String {
        return "Weight"
    }
    
    func barRightTitleText() -> String {
        return "Diet"
    }
    
    func barLeftDataText() -> String {
        return species.height
    }
    
    func barMiddleDataText() -> String {
        return species.weight
    }
    
    func barRightDataText() -> String {
        return species.diet.rawValue
    }
    
    func bodyText() -> String {
        return species.overview.replacingOccurrences(of: "\\n", with:"")
    }
    
    func learnMoreButtonTag() -> Int {
        return 0
    }
}

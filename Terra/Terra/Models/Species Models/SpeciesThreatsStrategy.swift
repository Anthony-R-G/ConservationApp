//
//  SpeciesThreatsStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct SpeciesThreatsStrategy: SpeciesStrategy {
    var species: Species
    
    func titleText() -> String {
        return "THREATS"
    }
    
    func barLeftTitleText() -> String {
        return ""
    }
    
    func barMiddleTitleText() -> String {
        return ""
    }
    
    func barRightTitleText() -> String {
        return ""
    }
    
    func barLeftDataText() -> String {
        return ""
    }
    
    func barMiddleDataText() -> String {
        return ""
    }
    
    func barRightDataText() -> String {
        return ""
    }
    
    func bodyText() -> String {
        return species.threats
    }
}
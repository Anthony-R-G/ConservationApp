//
//  SpeciesHabitatStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct SpeciesHabitatStrategy: SpeciesStrategy {
    var species: Species
    
    func titleText() -> String {
        return "HABITAT"
    }
    
    func bodyText() -> String {
        return species.habitat.summary
    }
    
    func barLeftTitleText() -> String {
        return "Temperature"
    }
    
    func barMiddleTitleText() -> String {
        return "Biome"
    }
    
    func barRightTitleText() -> String {
        return "Area"
    }
    
    func barLeftDataText() -> String {
        return species.habitat.temperature
    }
    
    func barMiddleDataText() -> String {
        return species.habitat.biome.rawValue
    }
    
    func barRightDataText() -> String {
        return species.habitat.area
    }
    
    func learnMoreButtonTag() -> Int {
        return 1
    }
}

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
        return "Humidity"
    }
    
    func barRightTitleText() -> String {
        return "Latitude"
    }
    
    func barLeftDataText() -> String {
        return species.habitat.temperature
    }
    
    func barMiddleDataText() -> String {
        return "" //No data for this yet
    }
    
    func barRightDataText() -> String {
        return "\(species.habitat.latitude)"
    }
}

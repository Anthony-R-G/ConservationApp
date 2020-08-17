//
//  LearnMoreHabitatLocationWindow.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/17/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct LearnMoreHabitatLocationWindow: LearnMoreContentWindowStrategy {
    var species: Species
    
    func titleLabel() -> String {
        return "LOCATION"
    }
    
    func contentView() -> UIView {
        return SpeciesMapView(species: species)
    }
}

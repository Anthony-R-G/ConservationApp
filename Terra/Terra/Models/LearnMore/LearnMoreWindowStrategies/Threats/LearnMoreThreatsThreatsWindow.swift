//
//  LearnMoreThreatsThreatsWindow.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/16/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct LearnMoreThreatsThreatsWindow: LearnMoreContentWindowStrategy {
    var species: Species
    
    func titleLabel() -> String {
        "THREATS"
    }
    
    func contentView() -> UIView {
        return Factory.makeLearnMoreWindowLabel(text: species.population.threats)
    }
}

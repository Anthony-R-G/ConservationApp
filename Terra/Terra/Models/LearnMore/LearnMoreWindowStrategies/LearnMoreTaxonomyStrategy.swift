//
//  LearnMoreTaxonomyStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct LearnMoreTaxonomyStrategy: LearnMoreContentWindowStrategy {

    var species: Species
    
    func titleLabel() -> String {
        "CLASSIFICATION"
    }
    
    func contentView() -> UIView {
        return TaxonomyView(species: species)
    }
}

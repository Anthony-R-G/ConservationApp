//
//  LearnMoreOverviewStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct LearnMoreVCOverviewStrategy: LearnMoreVCStrategy {
    var species: Species
    
   
    
    mutating func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            Factory.makeTextBasedLearnMoreWindow(strategy: LearnMoreOverviewDescription(species: species)),
            
            Factory.makeContentBasedLearnMoreWindow(height: 200, strategy: LearnMoreTaxonomyStrategy(species: species))
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }
}

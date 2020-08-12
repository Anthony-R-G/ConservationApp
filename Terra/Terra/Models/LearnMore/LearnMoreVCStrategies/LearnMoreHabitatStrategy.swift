//
//  LearnMoreHabitatStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct LearnMoreHabitatStrategy: LearnMoreVCStrategy {
    var species: Species
    
   
    
    mutating func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }
    
    init(species: Species) {
        self.species = species
    }
}

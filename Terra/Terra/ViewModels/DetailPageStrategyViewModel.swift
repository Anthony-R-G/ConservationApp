//
//  DetailPageStrategyViewModel.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/19/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

final class DetailPageStrategyViewModel {
    
    //MARK: -- Properties
    private var species: Species!
    
    private lazy var detailPageStrategies: [DetailPageStrategy] = [
        DetailOverviewStrategy(species: species),
        DetailHabitatStrategy(species: species),
        DetailThreatsStrategy(species: species)
    ]
    
    var totalStrategiesCount: Int {
        return detailPageStrategies.count
    }
    
    var selectedSpecies: Species {
        return species
    }
    
    //MARK: -- Methods
    
    func specificStrategy(at index: Int) -> DetailPageStrategy {
        return detailPageStrategies[index]
    }
    
    init(species: Species) {
        self.species = species
    }
}


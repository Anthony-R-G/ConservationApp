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
    private(set) var species: Species!
    
    private(set) lazy var detailPageStrategies: [DetailPageStrategy] = [
        DetailHabitatStrategy(species: species),
        DetailThreatsStrategy(species: species),
        DetailHowToHelpStrategy(species: species)
    ]
    
    //MARK: -- Methods
    
    func specificStrategy(at index: Int) -> DetailPageStrategy {
        return detailPageStrategies[index]
    }
    
    init(species: Species) {
        self.species = species
    }
}


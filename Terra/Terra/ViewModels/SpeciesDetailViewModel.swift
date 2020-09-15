//
//  DetailPageStrategyViewModel.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/19/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

final class SpeciesDetailViewModel {
    
    //MARK: -- Properties
    private var species: Species!
    
    private(set) lazy var detailPageStrategies: [DetailPageStrategy] = [
        DetailHabitatStrategy(viewModel: self),
        DetailThreatsStrategy(viewModel: self),
        DetailHowToHelpStrategy(viewModel: self)
    ]
    
    var speciesOverviewDescription: String {
        return species.overview
    }
    
    var speciesCommonName: String {
        return species.commonName
    }
    
    var speciesScientificName: String {
        return species.taxonomy.scientificName
    }
    
    var speciesConservationStatus: ConservationStatus {
        return species.population.conservationStatus
    }
    
    var speciesPopulationNumbers: String {
        return species.population.numbers
    }
    
    var speciesPopulationTrend: PopulationTrend {
        return species.population.trend
    }
    
    var speciesLastAssessedDate: Int {
        return species.population.assessmentDate
    }
    
    var speciesKingdom: String {
        return species.taxonomy.kingdom
    }
    
    var speciesPhylum: String {
        return species.taxonomy.phylum
    }
    
    var speciesClass: String {
        return species.taxonomy.classTaxonomy
    }
    
    var speciesOrder: String {
        return species.taxonomy.order
    }
    
    var speciesFamily: String {
        return species.taxonomy.family
    }
    
    var speciesGenus: String {
        return species.taxonomy.genus
    }
    
    var speciesDonationURL: String {
        return species.donationLink
    }
    
    var speciesMaleHeight: String {
        return species.measurements.averageMaleHeight
    }
    
    var speciesFemaleHeight: String {
        return species.measurements.averageFemaleHeight
    }
    
    var speciesMaleWeight: String {
        return species.measurements.averageMaleWeight
    }
    
    var speciesFemaleWeight: String {
        return species.measurements.averageFemaleWeight
    }
    
    var speciesAverageLifespan: String {
        return species.averageLifespan
    }
    
    var speciesHabitatSummary: String {
        return species.habitat.summary
    }
    
    var speciesLatitudeCoordinate: Double {
        return species.habitat.latitude
    }
    
    var speciesLongitudeCoordinate: Double {
        return species.habitat.longitude
    }
    
    var speciesBiome: Biome {
        return species.habitat.biome
    }
    
    var speciesArea: String {
        return species.habitat.area
    }
    
    var speciesTemperature: String {
        return species.habitat.temperature
    }
    
    var speciesPopulationSummary: String {
        return species.population.summary
    }
    
    var speciesThreats: [String] {
        return species.population.threats
    }
    
    var speciesMapboxStyleURL: String {
        return species.habitat.mapboxStyleURL
    }
    
    var speciesMapboxZoomAltitude: Double {
        return species.habitat.mapboxZoomAltitude
    }
 
    
    //MARK: -- Methods
    
    func specificStrategy(at index: Int) -> DetailPageStrategy {
        return detailPageStrategies[index]
    }
    
    
    init(species: Species) {
        self.species = species
    }
}


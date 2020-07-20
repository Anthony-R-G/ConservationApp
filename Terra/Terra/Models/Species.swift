//
//  FirebaseSpecies.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/13/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import FirebaseFirestore

public struct Species {
    let commonName: String
    let scientificName: String
    let assessmentDate: String
    let kingdom: String
    let phylum: String
    let order: String
    let classTaxonomy: String
    let family: String
    let genus: String
    let habitat: String
    let habitatSystem: HabitatSystem
    let threats: String
    let populationSummary: String
    let populationTrend: PopulationTrend
    let populationNumbers: String
    var conservationStatus: ConservationStatus
    let donationLink: String
    let weight: String
    let height: String
    let diet: Diet
    let cellImage: String
    let detailImage: String
    
    
    init? (from dict: [String: Any]) {
        guard let commonName = dict["commonName"] as? String,
            let scientificName = dict["scientificName"] as? String,
            let assessmentDate = dict["assessmentDate"] as? String,
            let kingdom = dict["kingdom"] as? String,
            let phylum = dict["phylum"] as? String,
            let order = dict["order"] as? String,
            let classTaxonomy = dict["classTaxonomy"] as? String,
            let family = dict["family"] as? String,
            let genus = dict["genus"] as? String,
            let habitat = dict["habitat"] as? String,
            let habitatSystemString = dict["habitatSystem"] as? String,
            let threats = dict["threats"] as? String,
            let populationSummary = dict["populationSummary"] as? String,
            let populationTrendString = dict["populationTrend"] as? String,
            let populationNumbers = dict["populationNumbers"] as? String,
            let conservationStatusString = dict["conservationStatus"] as? String,
            let donationLink = dict["donationLink"] as? String,
            let weight = dict["weight"] as? String,
            let height = dict["height"] as? String,
            let dietString = dict["diet"] as? String,
            let cellImage = dict["cellImage"] as? String,
            let detailImage = dict["detailImage"] as? String else { return nil }
        
        
        self.commonName = commonName
        self.scientificName = scientificName
        self.assessmentDate = assessmentDate
        self.kingdom = kingdom
        self.phylum = phylum
        self.order = order
        self.classTaxonomy = classTaxonomy
        self.family = family
        self.genus = genus
        self.habitat = habitat
        self.habitatSystem = HabitatSystem(rawValue: habitatSystemString)!
        self.threats = threats
        self.populationSummary = populationSummary
        self.populationTrend = PopulationTrend(rawValue: populationTrendString)!
        self.populationNumbers = populationNumbers
        self.conservationStatus = ConservationStatus(rawValue: conservationStatusString)!
        self.donationLink = donationLink
        self.weight = weight
        self.height = height
        self.diet = Diet(rawValue: dietString)!
        self.cellImage = cellImage
        self.detailImage = detailImage
    }
}

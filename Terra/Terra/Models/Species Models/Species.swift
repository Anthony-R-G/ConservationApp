//
//  Species.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/13/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

public struct Species: FirebaseConvertible {
    let commonName: String
    let scientificName: String
    let taxonomy: Taxonomy
    let group: Group
    let assessmentDate: String
    
    let habitatSummary: String
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
}

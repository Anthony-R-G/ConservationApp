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
    let assessmentDate: String
    let overview: String
    let taxonomy: Taxonomy
    let group: Group
    let habitat: Habitat
    let threats: String
    let populationSummary: String
    let populationTrend: PopulationTrend
    let populationNumbers: String
    let conservationStatus: ConservationStatus
    let donationLink: String
    let weight: String
    let height: String
    let diet: Diet
}

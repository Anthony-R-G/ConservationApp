//
//  Species.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/13/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct Species: FirebaseConvertible {
    let commonName: String
    let overview: String
    let measurements: Measurements
    let averageLifespan: String
    let donationLink: String
    let diet: Diet
    let taxonomy: Taxonomy
    let group: Group
    let habitat: Habitat
    let population: Population
    
    static func getFilteredSpeciesByName(arr: [Species], searchString: String) -> [Species] {
        return arr.filter{$0.commonName.lowercased().contains(searchString.lowercased())}
    }
    
    static func getFilteredSpeciesByConservationStatus(arr: [Species], by status: ConservationStatus) -> [Species] {
        return arr.filter{$0.population.conservationStatus == status}
    }
}


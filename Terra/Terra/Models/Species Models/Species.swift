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
    let averageLifespan: String
    let donationLink: String
    let measurements: Measurements
    let diet: Diet
    let taxonomy: Taxonomy
    let group: Group
    let habitat: Habitat
    let population: Population
    
    static func filterSpeciesByName(arr: [Species], searchString: String) -> [Species] {
        guard searchString != "" else { return arr }
        return arr.filter{$0.commonName.lowercased().contains(searchString.lowercased())}
    }
    
    static func filterByConservationStatus(arr: [Species], status: ConservationStatus?) -> [Species] {
        guard let status = status else { return arr }
       
        return arr.filter{$0.population.conservationStatus == status}
    }
}


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
    let overview: String
    let weight: String
    let height: String
    let donationLink: String
    let diet: Diet
    let taxonomy: Taxonomy
    let group: Group
    let habitat: Habitat
    let population: Population
}


//
//  Habitat.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct Habitat: FirebaseConvertible {
    let area: String
    let biome: Biome
    let latitude: Double
    let longitude: Double
    let summary: String
    let temperature: String
    let mapboxStyleURL: String
    let mapboxZoomAltitude: Double
}



//
//  Habitat.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct Habitat: FirebaseConvertible {
    let summary: String
    let system: HabitatSystem
    let temperature: String
    let latitude: Double
    let longitude: Double
}

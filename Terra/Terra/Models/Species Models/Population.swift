//
//  Population.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct Population: FirebaseConvertible {
    let trend: PopulationTrend
    let summary: String
    let numbers: String
    let assessmentDate: String
    let threats: String
}

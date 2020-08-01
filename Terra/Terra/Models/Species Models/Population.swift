//
//  Population.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct Population: FirebaseConvertible {
    let assessmentDate: Int
    let conservationStatus: ConservationStatus
    let numbers: String
    let summary: String
    let threats: String
    let trend: PopulationTrend
}

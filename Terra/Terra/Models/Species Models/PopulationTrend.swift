//
//  PopulationTrend.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/20/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

enum PopulationTrend: String, FirebaseConvertible {
    case decreasing = "Decreasing"
    case recovering = "Recovering"
    case stable = "Stable"
}

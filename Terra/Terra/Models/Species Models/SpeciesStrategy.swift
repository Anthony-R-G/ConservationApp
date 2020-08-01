//
//  SpeciesStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/31/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

protocol SpeciesStrategy {
    var species: Species { get }
    func titleText() -> String
    func bodyText() -> String
}

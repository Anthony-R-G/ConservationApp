//
//  LearnMoreWindowStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

protocol LearnMoreTextWindowStrategy {
    var species: Species { get set }
    
    func titleLabel() -> String
    func bodyText() -> String
}

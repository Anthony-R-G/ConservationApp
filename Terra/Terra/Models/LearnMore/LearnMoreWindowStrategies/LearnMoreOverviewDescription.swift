//
//  LearnMoreOverviewDescription.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct LearnMoreOverviewDescription: LearnMoreContentWindowStrategy {
    
    var species: Species
    
    func titleLabel() -> String {
        "DESCRIPTION"
    }
    
    func contentView() -> UIView {
        return Factory.makeLearnMoreWindowLabel(text: species.overview)
    }
}

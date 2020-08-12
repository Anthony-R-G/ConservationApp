//
//  LearnMoreOverviewStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct LearnMoreOverviewStrategy: LearnMoreStrategy {
     
    var species: Species
    
    private lazy var overviewSummaryView: OverviewSummaryView = {
       return OverviewSummaryView()
    }()
    
    private lazy var overviewDistributionView: OverviewDistributionView = {
        return OverviewDistributionView()
    }()
    
    mutating func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
        overviewSummaryView, overviewDistributionView
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }
    
    init(species: Species) {
        self.species = species
    }
}

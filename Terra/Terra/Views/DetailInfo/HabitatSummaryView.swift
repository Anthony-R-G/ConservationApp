//
//  HabitatSummaryView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/21/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class HabitatSummaryView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var biomeTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Biome",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var biomeDataLabel: UILabel = {
        return Factory.makeLabel(title: species.habitat.biome.rawValue,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var areaTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Phylum",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var areaDataLabel: UILabel = {
        return Factory.makeLabel(title: species.habitat.area,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            biomeTitleLabel, biomeDataLabel,
            areaTitleLabel, areaDataLabel
        ])
        sv.axis = .vertical
        sv.spacing = Constants.spacingConstant/2
        sv.setCustomSpacing(Constants.spacingConstant, after: biomeDataLabel)
//        sv.setCustomSpacing(Constants.spacingConstant, after: classDataLabel)
        return sv
    }()
    
    //MARK: -- Properties
    
    private var species: Species
    
    //MARK: -- Methods
    
  
}

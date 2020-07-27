//
//  SpeciesOverviewView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/20/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class SpeciesOverviewView: DetailInfoPanelView {

    public override func setViewElementsFromSpeciesData(species: Species) {
        bodyTextView.text = species.overview.replacingOccurrences(of: "\n", with: "\n")
        infoBarDataLabelA.text = species.height
        infoBarDataLabelB.text = species.weight
        infoBarDataLabelC.text = species.diet.rawValue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSpecificViewInfo(titleLabelStr: "OVERVIEW",
                                  infoBarTitleLabelAStr: "Height",
                                  infoBarTitleLabelBStr: "Weight",
                                  infoBarTitleLabelCStr: "Diet")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


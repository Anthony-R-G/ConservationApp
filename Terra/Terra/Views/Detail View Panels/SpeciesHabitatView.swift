//
//  SpeciesHabitatView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class SpeciesHabitatView: DetailInfoPanelView {
    
    public override func setViewElementsFromSpeciesData(species: Species) {
        self.bodyTextView.text = species.habitat.habitatSummary
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSpecificViewInfo(titleLabelStr: "HABITAT",
                                   infoBarTitleLabelAStr: "Temperature",
                                   infoBarTitleLabelBStr: "Humidity",
                                   infoBarTitleLabelCStr: "Latitude")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

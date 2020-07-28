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
        bodyTextView.text = species.habitat.summary
        infoBarDataLabelA.text = species.habitat.temperature
        infoBarDataLabelC.text = " \(species.habitat.latitude.rounded(toPlaces:1))°"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSpecificViewInfo(titleLabelStr: "HABITAT",
                                   infoBarTitleLabelAStr: "Temp",
                                   infoBarTitleLabelBStr: "Humidity",
                                   infoBarTitleLabelCStr: "Latitude")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




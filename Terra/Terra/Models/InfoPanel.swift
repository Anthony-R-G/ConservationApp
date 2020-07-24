//
//  DetailInfoPanelViewDelegate.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

protocol InfoPanel {
    func setViewUIForSpecificInfo(titleLabel: String, infoBarTitleLabelA: String, infoBarTitleLabelB: String, infoBarTitleLabelC: String) 
    
    func setViewElementsFromSpeciesData(species: Species)
}

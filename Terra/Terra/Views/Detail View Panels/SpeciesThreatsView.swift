//
//  SpeciesThreatsView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class SpeciesThreatsView: DetailInfoPanelView {
    
    public override func setViewElementsFromSpeciesData(species: Species) {
        bodyTextView.text = species.threats
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSpecificViewInfo(titleLabelStr: "THREATS", infoBarTitleLabelAStr: "", infoBarTitleLabelBStr: "", infoBarTitleLabelCStr: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

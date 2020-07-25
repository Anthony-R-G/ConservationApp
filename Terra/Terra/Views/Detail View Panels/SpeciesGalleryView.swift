//
//  SpeciesGalleryView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/25/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class SpeciesGalleryView: DetailInfoPanelView {
    
    public override func setViewElementsFromSpeciesData(species: Species) {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSpecificViewInfo(titleLabelStr: "GALLERY", infoBarTitleLabelAStr: "", infoBarTitleLabelBStr: "", infoBarTitleLabelCStr: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

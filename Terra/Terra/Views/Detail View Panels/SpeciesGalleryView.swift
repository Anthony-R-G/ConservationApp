//
//  SpeciesGalleryView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/25/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class SpeciesGalleryView: RoundedInfoView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabels(titleText: "GALLERY",
                                 barLeftTitle: "",
                                 barMiddleTitle: "",
                                 barRightTitle: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

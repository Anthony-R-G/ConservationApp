//
//  SpeciesHabitatView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class SpeciesHabitatView: RoundedInfoView {
    
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabels(titleText: "HABITAT",
                                 barLeftTitle: "Temp",
                                 barMiddleTitle: "Humidity",
                                 barRightTitle: "Latitude")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





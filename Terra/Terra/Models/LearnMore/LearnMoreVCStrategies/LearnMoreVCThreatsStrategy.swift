//
//  LearnMoreVCThreatsStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct LearnMoreVCThreatsStrategy: LearnMoreVCStrategy {
    var species: Species
    
    func title() -> String {
        return species.commonName
    }
    
    func subtitle() -> String {
        return "THREATS"
    }
    
    func firebaseStorageManager() -> FirebaseStorageService {
        return FirebaseStorageService.learnMoreThreatsImageManager
    }
    
    mutating func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            Factory.makeLearnMoreWindow(strategy: LearnMoreThreatsSummaryWindow(species: species)),
            
            Factory.makeLearnMoreWindow(strategy: LearnMoreThreatsThreatsWindow(species: species))
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.spacingConstant
        return stackView
    }
}

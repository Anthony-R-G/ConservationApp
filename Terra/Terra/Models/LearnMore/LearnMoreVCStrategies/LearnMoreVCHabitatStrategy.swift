//
//  LearnMoreHabitatStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct LearnMoreVCHabitatStrategy: LearnMoreVCStrategy {
    var species: Species
    
    func title() -> String {
        return species.commonName
    }
    
    func subtitle() -> String {
        return "HABITAT"
    }
    
    func firebaseStorageManager() -> FirebaseStorageService {
        return FirebaseStorageService.learnMoreHabitatImageManager
    }
    
    mutating func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            Factory.makeLearnMoreWindow(strategy: LearnMoreHabitatLocationWindow(species: species))
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.spacingConstant
        return stackView
    }
    
    init(species: Species) {
        self.species = species
    }
}

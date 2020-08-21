//
//  DetailHabitatStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct DetailHabitatStrategy: DetailPageStrategy {
    var species: Species
    
    func speciesName() -> String {
        return species.commonName
    }
    
    func pageName() -> String {
        return "HABITAT"
    }
    
    func firebaseStorageManager() -> FirebaseStorageService {
        return FirebaseStorageService.detailHabitatImageManager
    }
    
    mutating func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            DetailInfoWindow(title: "DISTRIBUTION",
                                         content: SpeciesMapView(species: species)),
            
            DetailInfoWindow(title: "BIOME", content: BiomeView(species: species)),
            
            DetailInfoWindow(title: "DETAIL", content:
                Factory.makeDetailInfoWindowLabel(text: species.habitat.summary))
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.spacingConstant
        return stackView
    }
    
    init(species: Species) {
        self.species = species
    }
}

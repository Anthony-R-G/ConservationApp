//
//  DetailHabitatStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class DetailHabitatStrategy: DetailPageStrategy {
    
    weak var biomeViewDelegate: BiomeViewDelegate?
    
    var species: Species
    
    var pageName: String {
        return "Habitat"
    }
    
    var firebaseStorageManager: FirebaseStorageService? {
        return FirebaseStorageService.detailHabitatImageManager
    }
    
    func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            DetailInfoWindow(title: "DISTRIBUTION",
                             content: DistributionView(species: species)),
            
            DetailInfoWindow(title: "BIOME",
                             content: BiomeView(strategy: self)),
            
            DetailInfoWindow(title: "DETAIL",
                             content: Factory.makeDetailInfoWindowLabel(text: species.habitat.summary)),
        ])
        
        stackView.axis = .vertical
        stackView.spacing = Constants.padding
        
        return stackView
    }
    
    init(species: Species) {
        self.species = species
    }
    
    func getDetailViewController() -> UIViewController {
        let detailVC = SpeciesDetailInfoViewController(strategy: self)
        biomeViewDelegate = detailVC
        return detailVC
    }
}



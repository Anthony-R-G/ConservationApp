//
//  DetailThreatsStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct DetailThreatsStrategy: DetailPageStrategy {
    var species: Species
    
    func speciesName() -> String {
        return species.commonName
    }
    
    func pageName() -> String {
        return "THREATS"
    }
    
    func firebaseStorageManager() -> FirebaseStorageService {
        return FirebaseStorageService.detailThreatsImageManager
    }
    
    mutating func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            
            DetailInfoWindow(title: "CONSERVATION STATUS", content: ConservationStatusView(species: species)),
            
            DetailInfoWindow(title: "POPULATION SUMMARY",
                                         content: Factory.makeDetailInfoWindowLabel(text: species.population.summary)),
            
            DetailInfoWindow(title: "THREATS",
                                         content: Factory.makeDetailInfoWindowLabel(text: species.population.threats))
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.spacingConstant
        return stackView
    }
}

//
//  DetailThreatsStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class DetailThreatsStrategy: DetailPageStrategy {
    var species: Species
    
    var pageName: String {
        return "Threats"
    }
    
    var firebaseStorageManager: FirebaseStorageService? {
        return FirebaseStorageService.detailThreatsImageManager
    }
    
    
     func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            
            DetailInfoWindow(title: "CONSERVATION STATUS", content: ConservationStatusView(species: species)),
            
            DetailInfoWindow(title: "POPULATION SUMMARY",
                             content: Factory.makeDetailInfoWindowLabel(text: species.population.summary)),
        ])
        
       
        _ = species.population.threats.map ({
            let threatComponents = $0.components(separatedBy: "%title")
            stackView.addArrangedSubview(
                DetailInfoWindow(
                    title: threatComponents[0],
                    content: Factory.makeDetailInfoWindowLabel(text: threatComponents[1])))
        })
     
        stackView.axis = .vertical
        stackView.spacing = Constants.padding
        return stackView
    }
    
    init(species: Species) {
        self.species = species
    }
}


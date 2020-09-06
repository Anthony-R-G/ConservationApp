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
    
    var pageName: String {
        return "THREATS"
    }
    
    var firebaseStorageManager: FirebaseStorageService? {
        return FirebaseStorageService.detailThreatsImageManager
    }
    
    mutating func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            
            DetailInfoWindow(title: "CONSERVATION STATUS", content: ConservationStatusView(species: species)),
            
            DetailInfoWindow(title: "POPULATION SUMMARY",
                             content: Factory.makeDetailInfoWindowLabel(text: species.population.summary)),
        ])
        
        for threat in species.population.threats {
            let threatsComponents = threat.components(separatedBy: "%title")
            stackView.addArrangedSubview(DetailInfoWindow(title: threatsComponents[0], content: Factory.makeDetailInfoWindowLabel(text: threatsComponents[1])))
        }
        
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        return stackView
    }
}


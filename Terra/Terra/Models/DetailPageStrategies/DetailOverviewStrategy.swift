//
//  DetailOverviewStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct DetailOverviewStrategy: DetailPageStrategy {
    var species: Species
    
    func speciesName() -> String {
        return species.commonName
    }
    
    func pageName() -> String {
        return "OVERVIEW"
    }
    
    func firebaseStorageManager() -> FirebaseStorageService {
        return FirebaseStorageService.detailOverviewImageManager
    }
    
    mutating func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            DetailInfoWindow(title: "DESCRIPTION",
                             content: Factory.makeDetailInfoWindowLabel(text: species.overview)),
            
            DetailInfoWindow(title: "CLASSIFICATION",
                             content: ClassificationView(species: species)),
            
            DetailInfoWindow(title: "MEASUREMENTS", content: MeasurementsView(species: species)),
            
            DetailInfoWindow(title: "AVERAGE LIFESPAN", content: Factory.makeDetailInfoWindowLabel(text: "\(species.averageLifespan) in the wild"))
            
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        return stackView
    }
}

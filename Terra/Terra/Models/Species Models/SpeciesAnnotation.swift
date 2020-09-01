//
//  SpeciesAnnotation.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/30/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Mapbox

final class SpeciesAnnotation: NSObject, MGLAnnotation {
    var species: Species!
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(species: Species) {
        self.species = species
        self.coordinate = CLLocationCoordinate2D(
            latitude: species.habitat.latitude,
            longitude: species.habitat.longitude)
        self.title = species.commonName
        self.subtitle = species.habitat.summary
    }
}

//
//  SpeciesAnnotation.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/30/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import Mapbox

class SpeciesAnnotation: NSObject, MGLAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var area: String
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, area: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.area = area
    }
}

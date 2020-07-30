//
//  SpeciesAnnotation.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/30/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import MapKit

class SpeciesAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
    
    var image: UIImage {
      guard let speciesName = title else {
        return #imageLiteral(resourceName: "Flag")
      }

      switch speciesName {
      case "Amur Leopard":
        return #imageLiteral(resourceName: "leopard")
      default:
        return #imageLiteral(resourceName: "Flag")
      }
    }
}

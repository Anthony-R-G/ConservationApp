//
//  TestModel(Elephant).swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct SpeciesInfo {
    let taxonID: Int
    let scientific_name: String
    let kingdom: String
    let phylum: String
    let order: String
    let family: String
    let genus: String
    let main_common_name: String
    let assessment_date: String
    let population_trend: String
    let marine_system: Bool
    let freshwater_system: Bool
    let terrestrial_system: Bool
    
    static let elephantTestInfo = SpeciesInfo(taxonID: 12392, scientific_name: "Loxodonta africana", kingdom: "Animalia", phylum: "Chordata", order: "Proboscidea", family: "Elephantidae", genus: "Loxodonta", main_common_name: "African Elephant", assessment_date: "2008-06-30", population_trend: "Increasing", marine_system: false, freshwater_system: false, terrestrial_system: true)
    
}

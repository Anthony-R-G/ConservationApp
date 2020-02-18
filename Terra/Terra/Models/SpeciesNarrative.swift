//
//  SpeciesNarrative.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct SpeciesNarrative{
    let speciesID: Int
    let habitat: String
    let threats: String
    let population: String
    
    static let elephantTestInfo = SpeciesNarrative(speciesID: 12392, habitat: "The African Elephant is very catholic in its range, and tends to move between a variety of habitats. It is found in dense forest, open and closed savanna, grassland and, at considerably lower densities, in the arid deserts of Namibia and Mali. They are also found over wide altitudinal and latitudinal ranges – from mountain slopes to oceanic beaches, and from the northern tropics to the southern temperate zone (approximately between 16.5° North and 34° South). See also the list of habitats.", threats: "Poaching for ivory and meat has traditionally been the major cause of the species' decline. Although illegal hunting remains a significant factor in some areas, particularly in Central Africa, currently the most important perceived threat is the loss and fragmentation of habitat caused by ongoing human population expansion and rapid land conversion. A specific manifestation of this trend is the reported increase in human-elephant conflict, which further aggravates the threat to elephant populations.", population: "Although elephant populations may at present be declining in parts of their range, major populations in Eastern and Southern Africa, accounting for over two thirds of all known elephants on the continent, have been surveyed, and are currently increasing at an average annual rate of 4.0% per annum (Blanc <span style=\"font-style: italic;\">et al</span>. 2005, 2007). As a result, more than 15,000 elephants are estimated to have been recruited into the population in 2006 and, if current rates of increase continue, the number of elephants born in these populations between 2005 and 2010 will be larger than the currently estimated total number of elephants in Central and West Africa combined. In other words, the magnitude of ongoing increases in Southern and Eastern Africa are likely to outweigh the magnitude of any likely declines in the other two regions.")
}

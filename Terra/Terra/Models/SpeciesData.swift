//
//  SpeciesData.swift
//  Terra
//
//  Created by Anthony Gonzalez on 2/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import UIKit

struct Species {
    let commonName: String
    let scientificName: String
    let assessmentDate: String
    let kingdom: String
    let phylum: String
    let order: String
    let classTaxonomy: String
    let family: String
    let genus: String
    let habitat: String
    let threats: String
    let populationSummary: String
    let populationTrend: String
    let populationNumbers: String
    let conservationStatus: String
    let marine_system: Bool
    let freshwater_system: Bool
    let terrestrial_system: Bool
    let collectionViewImage: UIImage
    let detailViewImage: UIImage
    let donationLink: String
    let weight: String
    let height: String
    
    
    static let listTestData: [Species] = [Species(commonName: "Lion", scientificName: "Panthera leo", assessmentDate: "1/01/2001", kingdom: "Animalia", phylum: "Chordata", order: "Carnivora", classTaxonomy: "Mammalia", family: "Felidae", genus: "Panthera", habitat: "African lions live in scattered populations across Sub-Saharan Africa. The lion prefers grassy plains and savannahs, scrub bordering rivers and open woodlands with bushes. It is absent from rainforest and rarely enters closed forest. On Mount Elgon, the lion has been recorded up to an elevation of 3,600 m (11,800 ft) and close to the snow line on Mount Kenya.[46] Lions occur in savannah grasslands with scattered acacia trees, which serve as shade.[74] The Asiatic lion now only survives in and around Gir National Park in Gujarat, western India. Its habitat is a mixture of dry savannah forest and very dry, deciduous scrub forest", threats: "A century ago, there were about 200,000 lions in the wild; today there are estimated to be less than 30,000. Lions used to roam the lands of Africa, but have lost about 80% of their historic range. They can be found mostly in Eastern and Southern Africa. One of the greatest threats to lions is human conflict. As they lose more of their habitat to human expansion and their prey base dwindles, they often prey on livestock. As a result, farmers often kill lions as a retaliatory or preventative measure. In Kenya alone, 100 lions are killed each year, leaving experts to believe there will be no lions left in Kenya by 2030. Canned hunting of lions is a huge business in South Africa. Approximately 600 lions are killed every year in trophy hunts. The male lion is the most sought after in hunts and when a male lion is killed, the whole pride faces instability. Other males may fight to the death to take over the pride and often the new male will kill the previous male’s cubs, thus eliminating an entire generation of the pride. There are actually breeding farms that breed lions just for canned hunts. Many people argue that breeding tame lions helps protect wild lion populations from being hunted, but that isn’t true. ", populationSummary: "For every lion in the wild, there are 14 African elephants, and there are 15 Western lowland gorillas. There are more rhinos than lions, too. The iconic species has disappeared from 94 percent of its historic range, which once included almost the entire African continent but is now limited to less than 660,000 square miles. With fewer than an estimated 25,000 in Africa, lions are listed as vulnerable to extinction by the International Union for the Conservation of Nature, which determines the conservation status of species.", populationTrend: "Decreasing", populationNumbers: "~20,000", conservationStatus: "Vulnerable", marine_system: false, freshwater_system: false, terrestrial_system: true, collectionViewImage: #imageLiteral(resourceName: "lionCellImage"), detailViewImage:#imageLiteral(resourceName: "lionDetailVC"), donationLink: "https://secure.awf.org/membership", weight: "280-480 lbs", height: "5-8 ft"), Species(commonName: "African Elephant", scientificName: "Loxodonta africana", assessmentDate: "1/1/2001", kingdom: "Animalia", phylum: "Chordata", order: "Mammalia", classTaxonomy: "Proboscidea", family: "Elephantidae", genus: "Loxodonta", habitat: "The African Elephant is very catholic in its range, and tends to move between a variety of habitats. It is found in dense forest, open and closed savanna, grassland and, at considerably lower densities, in the arid deserts of Namibia and Mali. They are also found over wide altitudinal and latitudinal ranges – from mountain slopes to oceanic beaches, and from the northern tropics to the southern temperate zone (approximately between 16.5° North and 34° South).", threats: "Poaching for ivory and meat has traditionally been the major cause of the species' decline. Although illegal hunting remains a significant factor in some areas, particularly in Central Africa, currently the most important perceived threat is the loss and fragmentation of habitat caused by ongoing human population expansion and rapid land conversion. A specific manifestation of this trend is the reported increase in human-elephant conflict, which further aggravates the threat to elephant populations.", populationSummary: "Although elephant populations may at present be declining in parts of their range, major populations in Eastern and Southern Africa, accounting for over two thirds of all known elephants on the continent, have been surveyed, and are currently increasing at an average annual rate of 4.0% per annum (Blanc <span style=\"font-style: italic;\">et al</span>. 2005, 2007). As a result, more than 15,000 elephants are estimated to have been recruited into the population in 2006 and, if current rates of increase continue, the number of elephants born in these populations between 2005 and 2010 will be larger than the currently estimated total number of elephants in Central and West Africa combined. In other words, the magnitude of ongoing increases in Southern and Eastern Africa are likely to outweigh the magnitude of any likely declines in the other two regions.", populationTrend: "Decreasing", populationNumbers: "~400,000", conservationStatus: "Threatened", marine_system: false, freshwater_system: false, terrestrial_system: true, collectionViewImage: #imageLiteral(resourceName: "elephantCellImage"), detailViewImage: #imageLiteral(resourceName: "elephantDetailVC"), donationLink: "https://secure.wcs.org/donate/donate-and-help-save-wildlife?_ga=2.98655773.265146746.1583628148-826700744.1583628148", weight: "2.5-7 tons", height: "13 ft"
    ),
    Species(commonName: "Bornean Orangutan", scientificName: "Pongo pygmaeus", assessmentDate: "1/01/2001", kingdom: "Animalia", phylum: "Chordata", order: "Primates", classTaxonomy: "Mammalia", family: "Hominidae", genus: "Pongo", habitat: "The Bornean orangutan lives in tropical and subtropical moist broadleaf forests in the Bornean lowlands, as well as mountainous areas up to 1,500 metres (4,900 ft) above sea level.[23] This species lives throughout the canopy of primary and secondary forests, and moves large distances to find trees bearing fruit.", threats: "All species of orangutans are critically endangered due to the loss, degradation, and fragmentation of their forest habitat. The threats are illegal logging, oil-palm plantations, forest fires, mining and small-scale shifting cultivation.", populationSummary: "Bornean orangutan populations have declined by more than 50% over the past 60 years, and the species' habitat has been reduced by at least 55% over the past 20 years.", populationTrend: "Decreasing", populationNumbers: "~7,500", conservationStatus: "Critical", marine_system: false, freshwater_system: false, terrestrial_system: true, collectionViewImage: #imageLiteral(resourceName: "borneanOrangutanCellImage"), detailViewImage: #imageLiteral(resourceName: "boreanOrangutanDetailVC"), donationLink: "https://www.theorangutanproject.org/donate/", weight: "110-220 lbs", height: "3-4.5 ft")]
    
}

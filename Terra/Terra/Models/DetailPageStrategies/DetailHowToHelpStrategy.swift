//
//  DetailHowToHelpStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/21/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class DetailHowToHelpStrategy: DetailPageStrategy {
    var species: Species
    
    var pageName: String {
        return "HOW TO HELP"
    }
    
    var firebaseStorageManager: FirebaseStorageService? {
        return nil
    }
    
    func arrangedSubviews() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            DetailInfoWindow(title: "ADOPT", content: Factory.makeDetailInfoWindowLabel(text: "From wild animals to wild places, there’s an option for everyone. Get together with classmates to adopt an animal from a wildlife conservation organization such as the World Wildlife Fund (WWF). Symbolic adoptions help fund organizations.")),
            
            
            DetailInfoWindow(title: "VOLUNTEER", content: Factory.makeDetailInfoWindowLabel(text: "If you don’t have money to give, donate your time. Many organizations and zoos have volunteer programs. You can help clean beaches, rescue wild animals or teach visitors.")),
            
            DetailInfoWindow(title: "VISIT", content: Factory.makeDetailInfoWindowLabel(text: "Zoos, aquariums, national parks and wildlife refuges are all home to wild animals. Learn more about our planet’s species from experts. See Earth’s most amazing creatures up close.")),
            
            DetailInfoWindow(title: "DONATE", content: Factory.makeDetailInfoWindowLabel(text: "When you visit your local accredited zoos and nature reserves, pay the recommended entry fee. Your donations help maintain these vital conservation areas.")),
            
            DetailInfoWindow(title: "SPEAK UP", content: Factory.makeDetailInfoWindowLabel(text: "Share your passion for wildlife conservation with your family. Tell your friends how they can help. Ask everyone you know to pledge to do what they can to stop wildlife trafficking.")),
            
            DetailInfoWindow(title: "BUY RESPONSIBLY", content: Factory.makeDetailInfoWindowLabel(text: "By not purchasing products made from endangered animals or their parts, you can stop wildlife trafficking from being a profitable enterprise.")),
            
            DetailInfoWindow(title: "PITCH IN", content: Factory.makeDetailInfoWindowLabel(text: " Trash isn’t just ugly, it’s harmful. Birds and other animals can trap their heads in plastic rings. Fish can get stuck in nets. Plus, trash pollutes everyone’s natural resources. Do your part by putting trash in its place.")),
            
            DetailInfoWindow(title: "RECYCLE", content: Factory.makeDetailInfoWindowLabel(text: "Find new ways to use things you already own. If you can’t reuse, recycle. The Minnesota Zoo encourages patrons to recycle mobile phones to reduce demand for the mineral coltan, which is mined from lowland gorillas’ habitats.")),
            
            DetailInfoWindow(title: "RESTORE", content: Factory.makeDetailInfoWindowLabel(text: "Habitat destruction is the main threat to 85 percent of all threatened and endangered species, according to the International Union for Conservation of Nature. You can help reduce this threat by planting native trees, restoring wetlands or cleaning up beaches in your area.")),
            
            DetailInfoWindow(title: "JOIN", content: Factory.makeDetailInfoWindowLabel(text: "Whether you’re into protecting natural habitats or preventing wildlife trafficking, find the organization that speaks to your passion and get involved. Become a member. Stay informed. Actively support the organization of your choice."))
            
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        return stackView
    }
    
    init(species: Species) {
        self.species = species
    }
}

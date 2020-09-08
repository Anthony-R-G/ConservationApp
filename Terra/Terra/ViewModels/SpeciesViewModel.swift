//
//  SpeciesViewModel.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/9/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import Combine

final class SpeciesViewModel: ObservableObject {
    //MARK: -- Properties
    
    private(set) var allSpecies: [Species] = []
    
    private var redListFilteredSpecies: [Species] = [] {
        didSet {
            searchFilteredSpecies = redListFilteredSpecies
        }
    }
    
    private var currentConservationStatusFilter: ConservationStatus? {
        didSet {
            guard let status = currentConservationStatusFilter else {
                redListFilteredSpecies = allSpecies
                return
            }
            
            redListFilteredSpecies = Species.filterByConservationStatus(arr: allSpecies, status: status)
        }
    }
    
    @Published private(set) var searchFilteredSpecies: [Species] = []
    
    
    var selectedTab: Int = 0 {
        didSet {
            switch selectedTab {
            case 0: currentConservationStatusFilter = nil
            case 1: currentConservationStatusFilter = .critical
            case 2: currentConservationStatusFilter = .endangered
            case 3: currentConservationStatusFilter = .vulnerable
            default:
                ()
            }
        }
    }
    
    private var publisher: AnyCancellable?
    
   @Published private var searchText = ""
    
    //MARK: -- Methods
    
    
    func updateSearchText(newText: String) {
        searchText = newText
        
    }
    
    init() {
        self.publisher = $searchText
        .receive(on: RunLoop.main)
        .sink(receiveValue: { (str) in
            if !self.searchText.isEmpty {
                self.searchFilteredSpecies = self.redListFilteredSpecies
                    .filter { $0.commonName.contains(str) }
            } else {
                self.searchFilteredSpecies = Species.filterByConservationStatus(arr: self.redListFilteredSpecies, status: self.currentConservationStatusFilter)
            }
        })
    }
}

extension SpeciesViewModel {
    func fetchSpeciesData() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            FirestoreService.manager.getAllSpeciesData() { (result) in
                switch result {
                case .success(let speciesData):
                    self.allSpecies = speciesData
                    self.redListFilteredSpecies = self.allSpecies
                    self.searchFilteredSpecies = self.redListFilteredSpecies
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

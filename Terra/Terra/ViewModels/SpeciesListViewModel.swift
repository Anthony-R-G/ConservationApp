//
//  SpeciesViewModel.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/9/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import Combine

final class SpeciesListViewModel: ObservableObject {
    //MARK: -- Properties
    
    private(set) var allSpecies: [Species] = []
    
    private var redListFilteredSpecies: [Species] = [] {
        didSet {
            searchFilteredSpecies = Species.filterSpeciesByName(arr: redListFilteredSpecies, searchString: searchText)
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
    
    private var publisher: AnyCancellable?
    
    @Published private var searchText = "" {
        didSet {
            searchFilteredSpecies = Species.filterSpeciesByName(arr: redListFilteredSpecies, searchString: searchText)
        }
    }
    
    //MARK: -- Methods

    
    func performSearch(_ searchText: String) {
        self.searchText = searchText
    }
    
    func updateConservationStatus(from value: Int) {
        switch value {
            case 0: currentConservationStatusFilter = nil
            case 1: currentConservationStatusFilter = .critical
            case 2: currentConservationStatusFilter = .endangered
            case 3: currentConservationStatusFilter = .vulnerable
            default:
                currentConservationStatusFilter = nil
        }
    }
    
//    private func setUpSearchTextBinding() {
//        self.publisher = $searchText
//            .receive(on: RunLoop.main)
//            .sink(receiveValue: { [weak self] (str) in
//                guard let self = self else { return }
//                if !self.searchText.isEmpty {
//                    self.searchFilteredSpecies = self.redListFilteredSpecies
//                        .filter { $0.commonName.contains(str) }
//                } else {
//                    self.searchFilteredSpecies = Species.filterByConservationStatus(arr: self.redListFilteredSpecies, status: self.currentConservationStatusFilter)
//                }
//            })
//    }
    
    
    
    init() {
//        setUpSearchTextBinding()
    }
}

extension SpeciesListViewModel {
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

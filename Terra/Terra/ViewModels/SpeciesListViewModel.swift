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
            searchFilteredSpecies = Species.filterSpeciesByName(
                arr: redListFilteredSpecies,
                searchString: search.value
            )
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
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private var search: CurrentValueSubject<String, Never>
    
    //MARK: -- Methods
    
    private func updateConservationStatus(from value: Int) {
        switch value {
        case 1: currentConservationStatusFilter = .critical
        case 2: currentConservationStatusFilter = .endangered
        case 3: currentConservationStatusFilter = .vulnerable
        default: currentConservationStatusFilter = nil
        }
    }
    
    init(searchPublisher: CurrentValueSubject<String, Never>, selectedFilterPublisher: CurrentValueSubject<Int, Never>) {
        self.search = searchPublisher
        
        Publishers.CombineLatest(search, selectedFilterPublisher)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
            .sink { [unowned self] (response) in
                self.searchFilteredSpecies = Species.filterSpeciesByName(
                    arr: self.redListFilteredSpecies,
                    searchString: response.0)
                
                self.updateConservationStatus(from: response.1)
        }
        .store(in: &subscriptions)
    }
}

extension SpeciesListViewModel {
    func fetchSpeciesData() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            FirestoreService.manager.getAllSpeciesData() { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let speciesData):
                    self.allSpecies = speciesData
                    self.redListFilteredSpecies = self.allSpecies
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}


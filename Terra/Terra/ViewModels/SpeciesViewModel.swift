//
//  SpeciesViewModel.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/9/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

final class SpeciesViewModel {
    //MARK: -- Properties
    
    private weak var delegate: SpeciesViewModelDelegate?
    
    private var animalData: [Species] = []
    
    private var redListCategoryFilteredAnimals: [Species] = [] {
        didSet {
            delegate?.fetchCompleted()
        }
    }
    
    /*
     var searchFilteredSpecies: [Species] {
     get {
     guard let searchString = searchString else { return redListCategoryFilteredAnimals }
     guard searchString != ""  else { return redListCategoryFilteredAnimals }
     return Species.getFilteredSpeciesByName(arr: redListCategoryFilteredAnimals, searchString: searchString)
     }
     }
     */
    
    var totalSpeciesCount: Int {
        return redListCategoryFilteredAnimals.count
    }
    
    //MARK: -- Properties
    func specificSpecies(at index: Int) -> Species {
        return redListCategoryFilteredAnimals[index]
    }
    
    func updateRedListCategoryFilteredAnimals(from buttonOption: ButtonOption) {
        switch buttonOption {
        case .buttonOne:
            redListCategoryFilteredAnimals = animalData
            
        case .buttonTwo:
            redListCategoryFilteredAnimals = Species.getFilteredSpeciesByConservationStatus(arr: animalData, by: .critical)
            
        case .buttonThree:
            redListCategoryFilteredAnimals = Species.getFilteredSpeciesByConservationStatus(arr: animalData, by: .endangered)
            
        case .buttonFour:
            redListCategoryFilteredAnimals =  Species.getFilteredSpeciesByConservationStatus(arr: animalData, by: .vulnerable)
        }
    }
    
    init(delegate: SpeciesViewModelDelegate) {
        self.delegate = delegate
    }
}

extension SpeciesViewModel {
    func fetchSpeciesData() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            FirestoreService.manager.getAllSpeciesData() { (result) in
                switch result {
                case .success(let speciesData):
                    self.animalData = speciesData
                    self.redListCategoryFilteredAnimals = speciesData
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

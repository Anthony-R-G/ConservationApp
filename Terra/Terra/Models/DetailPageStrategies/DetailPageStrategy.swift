//
//  LearnMoreStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

//Controls what's presented in the DetailInfoVC

protocol DetailPageStrategy {
    var species: Species { get set }
    mutating func getDetailViewController() -> UIViewController
    func speciesName() -> String
    func pageName() -> String
    func firebaseStorageManager() -> FirebaseStorageService
    mutating func arrangedSubviews() -> UIStackView
}

extension DetailPageStrategy {
     func getDetailViewController() -> UIViewController {
        let detailVC = SpeciesDetailInfoViewController()
        detailVC.strategy = self
        return detailVC
    }
}

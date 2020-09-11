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
    var pageName: String { get }
    var firebaseStorageManager: FirebaseStorageService? { get }
    mutating func arrangedSubviews() -> UIStackView
    mutating func getDetailViewController() -> UIViewController
//    func hash()
}

extension DetailPageStrategy {
     func getDetailViewController() -> UIViewController {
        let detailVC = SpeciesDetailInfoViewController(strategy: self)
        return detailVC
    }
}





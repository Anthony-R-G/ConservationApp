//
//  LearnMoreStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

//Controls what's presented in the LearnMoreVC

protocol DetailPageStrategy {
    var species: Species { get set }
    func speciesName() -> String
    func pageName() -> String
    func firebaseStorageManager() -> FirebaseStorageService
    mutating func arrangedSubviews() -> UIStackView
}

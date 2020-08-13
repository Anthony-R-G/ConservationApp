//
//  LearnMoreStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

//Controls what's presented in the LearnMoreVC

protocol LearnMoreVCStrategy {
    var species: Species { get set }
    func title() -> String
    func subtitle() -> String
    func firebaseStorageManager() -> FirebaseStorageService
    mutating func arrangedSubviews() -> UIStackView
}

//
//  OnboardingStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

protocol OnboardingStrategy {
    func videoFileName() -> String
    func displayedText() -> String
    func startButtonHidden() -> Bool
}

//
//  OnboardingPageTwo.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct OnboardingPageTwo: OnboardingStrategy {

    func videoFileName() -> String {
        return "kenyalion"
    }
    
    func displayedText() -> String {
        return "This is the worst mass-extinction since the Permian period, 250 million years ago"
    }
}

//
//  OnboardingPageFour.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct OnboardingPageFour: OnboardingStrategy {
    func videoFileName() -> String {
        return "bird"
    }
    
    func displayedText() -> String {
        return "The International Union for Conservation of Nature (IUCN) separates threatened species into three categories: \n \n •Critically Endangered \n \n •Endangered \n \n •Vulnerable"
    }
    
    func isLastPage() -> Bool {
        return false
    }
    
}

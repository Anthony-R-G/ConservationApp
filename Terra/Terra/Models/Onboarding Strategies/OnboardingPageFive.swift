//
//  OnboardingPageFive.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct OnboardingPageFive: OnboardingStrategy {
    func videoFileName() -> String {
        return "elephant"
    }
    
    func displayedText() -> String {
        return "Explore this app to learn more about these individual animals, and how you can play a part in protecting them \n \n We all share this planet together, so what affects them will affect us too"
    }
    
    func isLastPage() -> Bool {
        return true
    }
}

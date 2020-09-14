//
//  OnboardingPageThree.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct OnboardingPageThree: OnboardingStrategy {
    func videoFileName() -> String {
        return "lion"
    }
    
    func displayedText() -> String {
        return "Earth's species diversity is what makes it special \n \n Imagine a future where nobody has ever seen a lion in person"
    }
    
    func isLastPage() -> Bool {
        return false
    }
    
    
}

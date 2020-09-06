//
//  OnboardingPageTwo.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct OnboardingPageTwo: OnboardingStrategy {

    func videoFileName() -> String {
        return "lion"
    }
    
    func displayedText() -> String {
        return "PLACEHOLDER TEXT FOR PAGE 2"
    }
    
    func isLastPage() -> Bool {
        return true
    }
}

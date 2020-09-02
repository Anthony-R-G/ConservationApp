//
//  OnboardingPageOne.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct OnboardingPageOne: OnboardingStrategy {
    
    func videoFileName() -> String {
        return "Dolphin"
    }
    
    func displayedText() -> String {
        return "By 2050, half of Earth's species may become extinct"
    }
    
    func isLastPage() -> Bool {
        return false
    }
}

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
        return "trash"
    }
    
    func displayedText() -> String {
        return "Extinction is as old as life itself, but we have magnified the issue tenfold"
    }
    
    func isLastPage() -> Bool {
        return false
    }
}

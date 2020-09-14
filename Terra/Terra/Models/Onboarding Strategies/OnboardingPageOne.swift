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
        return "earthFromSpace"
    }
    
    func displayedText() -> String {
        return "It's estimated that by 2050, over 1 million species will become extinct \n \n This is 1 in every 10 animals and plants"
    }
    
    func isLastPage() -> Bool {
        return false
    }
}

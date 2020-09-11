//
//  OnboardingStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

protocol OnboardingStrategy {
    func videoFileName() -> String
    func displayedText() -> String
    func isLastPage() -> Bool
}

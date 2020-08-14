//
//  ToolBarDetailVCStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/4/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct ToolBarDetailVCStrategy: ToolBarVCStrategy {
    func buttonOneName() -> String {
        return "OVERVIEW"
    }
    
    func buttonTwoName() -> String {
        return "HABITAT"
    }
    
    func buttonThreeName() -> String {
        return "THREATS"
    }
    
    func buttonFourName() -> String {
        return "GALLERY"
    }
    
    func highlightIndicatorHidden() -> Bool {
        return false
    }
    
    func blurHidden() -> Bool {
        return false
    }
}

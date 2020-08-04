//
//  ToolBarListVCStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/4/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

struct ToolBarListVCStrategy: ToolBarVCStrategy {
    
    func buttonOneName() -> String {
        return "ALL"
    }
    
    func buttonTwoName() -> String {
        return "CRITICAL"
    }
    
    func buttonThreeName() -> String {
        return "ENDANGERED"
    }
    
    func buttonFourName() -> String {
        return "VULNERABLE"
    }
    
    func highlightIndicatorHidden() -> Bool {
        return true
    }
    
    
}

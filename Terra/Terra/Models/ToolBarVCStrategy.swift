//
//  ToolBarVCStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/4/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

protocol ToolBarVCStrategy {
    func buttonOneName() -> String
    func buttonTwoName() -> String
    func buttonThreeName() -> String
    func buttonFourName() -> String
    func highlightIndicatorHidden() -> Bool
}

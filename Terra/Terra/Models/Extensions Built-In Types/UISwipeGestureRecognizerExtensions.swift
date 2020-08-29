//
//  UISwipeGestureRecognizer.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/19/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

extension UISwipeGestureRecognizer.Direction {
    var opposite: UISwipeGestureRecognizer.Direction {
        switch self {
        case .up: return .down
        case .down: return .up
        default: ()
        }
        return self.opposite
    }
}

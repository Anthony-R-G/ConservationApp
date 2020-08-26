//
//  Utilities.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct Utilities {
    
    static let generator = UIImpactFeedbackGenerator(style: .medium)
    
    static func addParallaxToView(view: UIView) {
        let amount = 40
        
        let horizontalMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotion.minimumRelativeValue = -amount
        horizontalMotion.maximumRelativeValue = amount
        
        let verticalMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotion.minimumRelativeValue = -amount
        verticalMotion.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotion, verticalMotion]
        view.addMotionEffect(group)
    }
}

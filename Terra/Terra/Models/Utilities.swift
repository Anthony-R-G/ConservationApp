//
//  Utilities.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct Utilities {

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
    
    static func sendHapticFeedback(action: UserAction) {
        let itemSelectedFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        let pageDismissedFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        let changedSelectionFeedbackGenerator = UISelectionFeedbackGenerator()
       
        switch action {
        case .itemSelected: itemSelectedFeedbackGenerator.impactOccurred()
        case .pageDismissed: pageDismissedFeedbackGenerator.impactOccurred()
        case .selectionChanged: changedSelectionFeedbackGenerator.selectionChanged()
        }
    }
    
    private init() {}
}

enum UserAction {
    case itemSelected
    case pageDismissed
    case selectionChanged
}

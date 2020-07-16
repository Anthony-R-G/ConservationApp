//
//  UIViewExtensions.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/16/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

extension UIView {
    
    func addBlurToView() {
        var blurEffect: UIBlurEffect!
        blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = PSORoundedVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.bounds
        blurredEffectView.alpha = 0.8
        blurredEffectView.layer.cornerRadius = 30
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.insertSubview(blurredEffectView, at: 0)
    }
}

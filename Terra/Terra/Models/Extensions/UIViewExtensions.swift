//
//  UIViewExtensions.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/16/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

extension UIView {
    func addBlurToView(cornerRadius: CGFloat) {
        var blurEffect: UIBlurEffect!
        blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurredEffectView = PSORoundedVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.bounds
        blurredEffectView.alpha = 0.9
        blurredEffectView.layer.cornerRadius = cornerRadius
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.insertSubview(blurredEffectView, at: 0)
    }
}

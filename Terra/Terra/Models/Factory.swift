//
//  Utilities.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class Factory {
    static func makeLabel(title: String?,
                          weight: FontWeight,
                          size: CGFloat,
                          color: UIColor,
                          alignment: NSTextAlignment) -> UILabel {
        
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: weight.rawValue, size: size.deviceAdjusted)
        label.textAlignment = alignment
        label.textColor = color
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }
    
    static func makeDetailInfoWindowLabel(text: String) -> UILabel {
        let label = makeLabel(
            title: text.replacingOccurrences(of: "\\n", with: "\n"),
            weight: .regular,
            size: 16,
            color: .white,
            alignment: .natural)
        label.numberOfLines = 0
        return label
    }
    
    
    static func makeButton(title: String, weight: FontWeight, color: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: weight.rawValue, size: 15.deviceAdjusted)
        return button
    }
    
    static func makeBlurredCircleButton(image: systemImage, style: ButtonStyle) -> CircleBlurButton {
        let button = CircleBlurButton(frame: CGRect(
            origin: .zero,
            size: CGSize(
                width: 35.deviceAdjusted,
                height: 35.deviceAdjusted))
            ,image: UIImage(systemName: image.rawValue)!,
             style: style)
        
        button.snp.makeConstraints { (make) in
            make.height.width.equalTo(button.frame.size) }
        return button
    }
}

enum systemImage: String {
    case close = "xmark"
    case augmentedReality = "arkit"
    case list = "list.dash"
}




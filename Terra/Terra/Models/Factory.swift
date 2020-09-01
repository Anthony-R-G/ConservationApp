//
//  Utilities.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class Factory {
    static func makeLabel(
        title: String?,
        fontWeight: FontWeight,
        fontSize: CGFloat,
        widthAdjustsFontSize: Bool,
        color: UIColor,
        alignment: NSTextAlignment) -> UILabel {
        
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: fontWeight.rawValue, size: fontSize.deviceScaled)
        label.textAlignment = alignment
        label.textColor = color
        if widthAdjustsFontSize == true {
            label.adjustsFontSizeToFitWidth = true
            label.sizeToFit()
        }
        return label
    }
    
    static func makeDetailInfoWindowLabel(text: String) -> UILabel {
        let label = makeLabel(
            title: text.replacingOccurrences(of: "\\n", with: "\n"),
            fontWeight: .regular,
            fontSize: 16,
            widthAdjustsFontSize: true,
            color: .white,
            alignment: .natural)
        label.numberOfLines = 0
        return label
    }
    
        
    static func makeBlurredCircleButton(image: systemImage, style: ButtonStyle, size: ButtonSize ) -> CircleBlurButton {
        let size: CGSize = size == .regular ? Constants.buttonSizeRegular : Constants.buttonSizeSmall
        let button = CircleBlurButton(
            frame: CGRect(
                origin: .zero,
                size: size),
            
            image: UIImage(systemName: image.rawValue)!,
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
    case share = "square.and.arrow.up"
    case refresh = "arrow.clockwise"
}

enum ButtonSize {
    case small
    case regular
}




//
//  UIImageExtensions.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/18/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0,
                          y: size.height - lineWidth,
                          width: size.width,
                          height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

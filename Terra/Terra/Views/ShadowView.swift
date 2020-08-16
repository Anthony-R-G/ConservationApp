//
//  ShadowView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/15/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowOpacity = 0.25
        layer.masksToBounds = false
    }
}

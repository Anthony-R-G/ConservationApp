//
//  PSORoundedVisualEffectView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/16/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class PSORoundedVisualEffectView : UIVisualEffectView{

    override func layoutSubviews() {
        super.layoutSubviews()
        updateMaskLayer()
    }

    func updateMaskLayer(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 39).cgPath
        self.layer.mask = shapeLayer
    }
}

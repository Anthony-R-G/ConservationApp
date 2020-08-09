//
//  DonateButton.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class DonateButton: UIRoundedButtonWithGradientAndShadow {
    
    //MARK: -- Properties
    weak var delegate: DonateButtonDelegate?
    
    
    //MARK: -- Methods
    @objc func buttonIsPressed() {
        delegate?.donateButtonPressed()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(gradientColors: [UIColor],
                  startPoint: CGPoint = CGPoint(x: 0, y: 0.5),
                  endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        super.init(gradientColors: gradientColors, startPoint: startPoint, endPoint: endPoint)
        setTitle("DONATE", for: .normal)
        titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
        addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        showsTouchWhenHighlighted = true
    }
}


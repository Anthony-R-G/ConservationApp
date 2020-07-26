//
//  DonateButton.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class DonateButton: UIButton {
    
    //MARK: -- Properties
    weak var delegate: DonateButtonDelegate?
    
    
    //MARK: -- Methods
    @objc func buttonIsPressed() {
        delegate?.donateButtonPressed()
    }
    
    private func setBehavior() {
        self.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        self.isUserInteractionEnabled = true
    }
    
    private func setAppearance() {
        setTitle("DONATE", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Roboto-Bold", size: 20)
        showsTouchWhenHighlighted = true
        clipsToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.0
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        addSubviews()
        //        setConstraints()
        setBehavior()
    }
    
    override func draw(_ rect: CGRect) {
        setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

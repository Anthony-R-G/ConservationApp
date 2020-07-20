//
//  DonateButton.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/20/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class DonateButton: UIButton {
    
    //MARK: -- UI Element Initialization
    private lazy var donateLabel: UILabel = {
        let label = UILabel()
        label.text = "Donate"
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 1, green: 0.2884941101, blue: 0.4681258202, alpha: 0.8975545805)
        gv.endColor = #colorLiteral(red: 0.9966140389, green: 0.3340439796, blue: 0.6428459883, alpha: 0.8956817209)
        gv.diagonalMode = true
        gv.translatesAutoresizingMaskIntoConstraints = false
        gv.isUserInteractionEnabled = false
        self.insertSubview(gv, at: 0)
        return gv
    }()
    
    var delegate: InfoOptionPanelDelegate?
    
    
    @objc func buttonIsPressed() {
        delegate?.donateButtonPressed()
    }
    
    
    private func setBehavior() {
        self.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        self.isUserInteractionEnabled = true
    }
    
    private func setAppearance() {
        self.showsTouchWhenHighlighted = true
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        setBehavior()
    }
    
    override func draw(_ rect: CGRect) {
        setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: -- Adding Subviews & Constraints
extension DonateButton {
    
    private func addSubviews() {
        let UIElements = [donateLabel]
        UIElements.forEach { self.addSubview( $0 ) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setBackgroundGradientOverlayConstraints()
        setDonateLabelConstraints()
    }
    
    private func setBackgroundGradientOverlayConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientOverlay.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundGradientOverlay.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backgroundGradientOverlay.widthAnchor.constraint(equalTo: self.widthAnchor),
            backgroundGradientOverlay.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    private func setDonateLabelConstraints() {
        NSLayoutConstraint.activate([
            donateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            donateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            donateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            donateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


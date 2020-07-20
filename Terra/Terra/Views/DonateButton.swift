//
//  DonateButton.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/20/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

@IBDesignable
class DonateButton: UIButton {
    
    //MARK: -- UI Element Initialization
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 1, green: 0.2914688587, blue: 0.3886995912, alpha: 0.9019156678)
        gv.endColor = #colorLiteral(red: 0.5421239734, green: 0.1666001081, blue: 0.2197911441, alpha: 0.8952536387)
        gv.diagonalMode = true
        gv.translatesAutoresizingMaskIntoConstraints = false
        gv.isUserInteractionEnabled = false
        self.insertSubview(gv, at: 0)
        return gv
    }()
    
    private lazy var glyphImage: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = false
        iv.image = #imageLiteral(resourceName: "donateButtonGlyph")
        iv.backgroundColor = .clear
        return iv
    }()
    
    private lazy var donateLabel: UILabel = {
        let label = UILabel()
        label.text = "Donate"
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        return label
    }()
    
    
    //MARK: -- Properties
    var delegate: InfoOptionPanelDelegate?
    
    
    //MARK: -- Methods
    @objc func buttonIsPressed() {
        delegate?.donateButtonPressed()
    }
    
    private func setBehavior() {
        self.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        self.isUserInteractionEnabled = true
    }
    
    private func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    private func setAppearance() {
        self.showsTouchWhenHighlighted = true
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.0
        
//        setShadow()
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
        let UIElements = [glyphImage, donateLabel]
        UIElements.forEach { self.addSubview( $0 ) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setBackgroundGradientOverlayConstraints()
        setGlyphImageConstraints()
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
    
    private func setGlyphImageConstraints() {
        NSLayoutConstraint.activate([
            glyphImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            glyphImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            glyphImage.widthAnchor.constraint(equalToConstant: 40),
            glyphImage.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setDonateLabelConstraints() {
        NSLayoutConstraint.activate([
            donateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            donateLabel.topAnchor.constraint(equalTo: glyphImage.bottomAnchor, constant: -15),
            donateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            donateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


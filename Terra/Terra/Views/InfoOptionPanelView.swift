//
//  InfoOptionPanelView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/20/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class InfoOptionPanelView: UIView {
    
    //MARK: -- UI Element Initialization
    
    lazy var donateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Donate", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 20)
        button.backgroundColor = .orange
        button.showsTouchWhenHighlighted = true
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(donateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: -- Properties
    
    var delegate: InfoOptionPanelDelegate?
    
    //MARK: -- Methods
    
    @objc func donateButtonPressed() {
        delegate?.donateButtonPressed()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addBlurToView()
        self.layer.cornerRadius = 39
        addSubviews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -- Adding Subviews & Constraints

extension InfoOptionPanelView {
    
    private func addSubviews() {
        let UIElements = [donateButton]
        UIElements.forEach { self.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setDonateButtonConstraints()
    }
    
    private func setDonateButtonConstraints() {
        NSLayoutConstraint.activate([
            donateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            donateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            donateButton.heightAnchor.constraint(equalTo: self.heightAnchor),
            donateButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

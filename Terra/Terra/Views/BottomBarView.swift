//
//  BottomBarView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class BottomBarView: UIView {
    //MARK: -- Lazy UI Element Initialization
    private lazy var overviewButton: UIButton = {
        let btn = Utilities.makeBottomBarButton(title: "OVERVIEW")
        btn.tag = 0
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var threatsButton: UIButton = {
        let btn = Utilities.makeBottomBarButton(title: "THREATS")
        btn.tag = 1
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var habitatButton: UIButton = {
        let btn = Utilities.makeBottomBarButton(title: "HABITAT")
        btn.tag = 2
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var galleryButton: UIButton = {
        let btn = Utilities.makeBottomBarButton(title: "GALLERY")
        btn.tag = 3
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [overviewButton, threatsButton, habitatButton, galleryButton])
        sv.axis = .horizontal
        sv.spacing = 3
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private lazy var highlightedIndicator: UIView = {
        let screenWidth = UIScreen.main.bounds.width
        let view = UIView(frame: CGRect(x: .zero, y: .zero, width: screenWidth / 4.55, height: 2))
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    private lazy var highlightedIndicatorLeadingAnchorConstraint: NSLayoutConstraint = {
        highlightedIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
    }()
    
    //MARK: -- Properties
    
    weak var actionDelegate: BottomBarDelegate?
    
    //MARK: -- Methods
    private func setAppearance() {
        addBlurToView(cornerRadius: 0)
    }
    
    public func updateHighlightIndicator(scrollOffset: CGFloat) {
        let highlightOffset = scrollOffset/4.01 + 12
        let newHighlightLeadingConstant = min(UIScreen.main.bounds.width - 100, max(highlightOffset, 10))
        highlightedIndicatorLeadingAnchorConstraint.constant = newHighlightLeadingConstant
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    public func highlightButton(button: ButtonOption) {
        switch button {
        case .overviewButton:
            overviewButton.isSelected = true
            [threatsButton, habitatButton, galleryButton].forEach { $0.isSelected = false }
            
        case .threatsButton:
            threatsButton.isSelected = true
            [overviewButton, habitatButton, galleryButton].forEach { $0.isSelected = false }
            
        case .habitatButton:
            habitatButton.isSelected = true
            [threatsButton, overviewButton, galleryButton].forEach { $0.isSelected = false }
            
        case .galleryButton:
            galleryButton.isSelected = true
            [threatsButton, habitatButton, overviewButton].forEach { $0.isSelected = false }
        }
    }
    
    @objc private func bottomBarButtonPressed(sender: UIButton) {
        actionDelegate?.buttonPressed(sender)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAppearance()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomBarView {
    
    private func addSubviews() {
        let UIElements = [buttonStackView, highlightedIndicator]
        UIElements.forEach { self.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setButtonStackViewConstraints()
        setHighlightedIndicatorConstraints()
        
    }
    
    private func setButtonStackViewConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    private func setHighlightedIndicatorConstraints() {
        NSLayoutConstraint.activate([
            highlightedIndicator.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 0),
            highlightedIndicator.widthAnchor.constraint(equalToConstant: highlightedIndicator.frame.size.width),
            highlightedIndicator.heightAnchor.constraint(equalToConstant: highlightedIndicator.frame.size.height),
            highlightedIndicatorLeadingAnchorConstraint
        ])
    }
}

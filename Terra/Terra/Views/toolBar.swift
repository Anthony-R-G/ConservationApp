//
//  BottomBarView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class toolBar: UIView {
    //MARK: -- Lazy UI Element Initialization
    
    private lazy var buttonOne: UIButton = {
        let btn = Factory.makeToolBarButton(title: viewControllerStrategy.buttonOneName())
        btn.tag = 0
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var buttonTwo: UIButton = {
        let btn = Factory.makeToolBarButton(title: viewControllerStrategy.buttonTwoName())
        btn.tag = 1
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var buttonThree: UIButton = {
        let btn = Factory.makeToolBarButton(title: viewControllerStrategy.buttonThreeName())
        btn.tag = 2
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var buttonFour: UIButton = {
        let btn = Factory.makeToolBarButton(title: viewControllerStrategy.buttonFourName())
        btn.tag = 3
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [buttonOne, buttonTwo, buttonThree, buttonFour])
        sv.axis = .horizontal
        sv.spacing = 3
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private lazy var highlightedIndicator: UIView = {
        let screenWidth = UIScreen.main.bounds.width
        let view = UIView(frame: CGRect(x: .zero, y: .zero, width: screenWidth / 4.55, height: Constants.borderWidth))
        view.backgroundColor = UIColor.white
        view.isHidden = viewControllerStrategy.highlightIndicatorHidden()
        return view
    }()
    
    private lazy var highlightedIndicatorLeadingAnchorConstraint: NSLayoutConstraint = {
        highlightedIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
    }()
    
    //MARK: -- Properties
    
    var viewControllerStrategy: ToolBarVCStrategy
    
    weak var delegate: BottomBarDelegate?
    
    //MARK: -- Methods
    
    public func updateHighlightIndicator(scrollOffset: CGFloat) {
        let highlightOffset = scrollOffset/4.01 + 12
        let newHighlightLeadingConstant = min(UIScreen.main.bounds.width - 100, max(highlightOffset, 10))
        highlightedIndicatorLeadingAnchorConstraint.constant = newHighlightLeadingConstant
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    public func highlightButton(button: ToolBarSelectedButton) {
        switch button {
        case .buttonOne:
            buttonOne.isSelected = true
            [buttonThree, buttonTwo, buttonFour].forEach { $0.isSelected = false }
            
        case .buttonTwo:
            buttonTwo.isSelected = true
            [buttonThree, buttonOne, buttonFour].forEach { $0.isSelected = false }
            
        case .buttonThree:
            buttonThree.isSelected = true
            [buttonOne, buttonTwo, buttonFour].forEach { $0.isSelected = false }
            
        case .buttonFour:
            buttonFour.isSelected = true
            [buttonThree, buttonTwo, buttonOne].forEach { $0.isSelected = false }
        }
    }
    
    @objc private func bottomBarButtonPressed(sender: UIButton) {
        delegate?.buttonPressed(sender)
    }
    
    
    init(frame: CGRect, strategy: ToolBarVCStrategy) {
        viewControllerStrategy = strategy
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        if !strategy.blurHidden() {
            addBlurToView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension toolBar {
    
    func addSubviews() {
        let UIElements = [buttonStackView, highlightedIndicator]
        UIElements.forEach { addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setButtonStackViewConstraints()
        setHighlightedIndicatorConstraints()
        
    }
    
    func setButtonStackViewConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.universalLeadingConstant),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.universalLeadingConstant),
            buttonStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    func setHighlightedIndicatorConstraints() {
        NSLayoutConstraint.activate([
            highlightedIndicator.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 0),
            highlightedIndicator.widthAnchor.constraint(equalToConstant: highlightedIndicator.frame.size.width),
            highlightedIndicator.heightAnchor.constraint(equalToConstant: highlightedIndicator.frame.size.height),
            highlightedIndicatorLeadingAnchorConstraint
        ])
    }
}

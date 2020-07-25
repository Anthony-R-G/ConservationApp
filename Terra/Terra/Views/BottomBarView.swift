//
//  BottomBarView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

enum buttonOption {
    case overviewButton
    case threatsButton
    case habitatButton
    case galleryButton
}

class BottomBarView: UIToolbar {
    //MARK: -- Lazy UI Element Initialization
    
    private lazy var overviewButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("OVERVIEW", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .selected)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.addTarget(self, action: #selector(overviewButtonPressed), for: .touchUpInside)
        button.sizeToFit()
        return button
    }()
    
    private lazy var overviewBarButtonItem: UIBarButtonItem = {
        var btn = UIBarButtonItem(customView: overviewButton)
        return btn
    }()
    
    private lazy var threatsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("THREATS", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .selected)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.addTarget(self, action: #selector(threatsButtonPressed), for: .touchUpInside)
        button.sizeToFit()
        return button
    }()
    
    private lazy var threatsBarButtonItem: UIBarButtonItem = {
        var btn = UIBarButtonItem(customView: threatsButton)
        return btn
    }()
    
    private lazy var habitatButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("HABITAT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .selected)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.addTarget(self, action: #selector(habitatButtonPressed), for: .touchUpInside)
        button.sizeToFit()
        return button
    }()
    
    private lazy var habitatBarButtonItem: UIBarButtonItem = {
        var btn = UIBarButtonItem(customView: habitatButton)
        return btn
    }()
    
    private lazy var galleryButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("GALLERY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .selected)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.addTarget(self, action: #selector(galleryButtonPressed), for: .touchUpInside)
        button.sizeToFit()
        return button
    }()
    
    private lazy var galleryBarButtonItem: UIBarButtonItem = {
        var btn = UIBarButtonItem(customView: galleryButton)
        return btn
    }()
    
    private lazy var spacer: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        return btn
    }()
    
    //MARK: -- Properties
    
    weak var actionDelegate: BottomBarDelegate?
    
    
    //MARK: -- Methods
    private func setAppearance() {
        barStyle = .black
    }
    
    public func highlightButton(button: buttonOption) {
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
    
    @objc private func overviewButtonPressed() {
        actionDelegate?.overviewButtonPressed(overviewButton)
    }
    
    @objc private func threatsButtonPressed() {
        actionDelegate?.threatsButtonPressed(threatsButton)
    }
    
    @objc private func habitatButtonPressed() {
        actionDelegate?.habitatButtonPressed(habitatButton)
    }
    
    @objc private func galleryButtonPressed() {
        actionDelegate?.galleryButtonPressed(galleryButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAppearance()
        
        let barButtonItems = [overviewBarButtonItem, spacer, threatsBarButtonItem, spacer, habitatBarButtonItem, spacer, galleryBarButtonItem]
        items = barButtonItems
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

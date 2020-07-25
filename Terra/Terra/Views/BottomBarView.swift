//
//  BottomBarView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class BottomBarView: UIToolbar {
    //MARK: -- Lazy UI Element Initialization
    
    private lazy var overviewButton: UIButton = {
        let btn = Utilities.makeBottomBarButton(title: "OVERVIEW")
        btn.tag = 0
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var overviewBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(customView: overviewButton)
    }()
    
    private lazy var threatsButton: UIButton = {
        let btn = Utilities.makeBottomBarButton(title: "THREATS")
        btn.tag = 1
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var threatsBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(customView: threatsButton)
    }()
    
    private lazy var habitatButton: UIButton = {
        let btn = Utilities.makeBottomBarButton(title: "HABITAT")
        btn.tag = 2
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var habitatBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(customView: habitatButton)
    }()
    
    private lazy var galleryButton: UIButton = {
        let btn = Utilities.makeBottomBarButton(title: "GALLERY")
        btn.tag = 3
        btn.addTarget(self, action: #selector(bottomBarButtonPressed(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var galleryBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(customView: galleryButton)
    }()
    
    private lazy var spacer: UIBarButtonItem = {
        let fs = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        return fs
    }()
    
    //MARK: -- Properties
    
    weak var actionDelegate: BottomBarDelegate?
    
    
    //MARK: -- Methods
    private func setAppearance() {
        barStyle = .black
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

        items = [overviewBarButtonItem, spacer, threatsBarButtonItem, spacer, habitatBarButtonItem, spacer, galleryBarButtonItem]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

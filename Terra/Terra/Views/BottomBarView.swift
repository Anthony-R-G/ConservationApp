//
//  BottomBarView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class BottomBarView: UIToolbar {
    
    
    private lazy var overviewButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setTitle("OVERVIEW", for: .normal)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(overviewButtonPressed), for: .touchUpInside)
        button.sizeToFit()
        
        var btn = UIBarButtonItem(customView: button)
        return btn
    }()
    
    private lazy var threatsButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setTitle("THREATS", for: .normal)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.setTitleColor(.white, for: .normal)
        
        button.sizeToFit()
        
        var btn = UIBarButtonItem(customView: button)
        return btn
    }()
    
    private lazy var habitatButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setTitle("HABITAT", for: .normal)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.setTitleColor(.white, for: .normal)
        
        button.sizeToFit()
        
        var btn = UIBarButtonItem(customView: button)
        return btn
    }()
    
    private lazy var galleryButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setTitle("GALLERY", for: .normal)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.setTitleColor(.white, for: .normal)
        
        button.sizeToFit()
        
        var btn = UIBarButtonItem(customView: button)
        return btn
    }()
    
    private lazy var spacer: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        return btn
    }()
    
    weak var actionDelegate: BottomBarDelegate?
    
    
    private func setAppearance() {
        barStyle = .black
    }
    
    @objc func overviewButtonPressed() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAppearance()
        for view in overviewButton.customView!.subviews {
            print(view)
        }
        
        let barButtonItems = [overviewButton, spacer, threatsButton, spacer, habitatButton, spacer, galleryButton]
        items = barButtonItems
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

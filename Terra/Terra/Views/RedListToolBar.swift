//
//  RedListToolBar.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/18/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class RedListFilterTabBar: UITabBar {
    //MARK: -- UI Element Initialization
    
    private lazy var allTab: UITabBarItem = {
        var btn = UITabBarItem(title: "ALL", image: nil, tag: 0)
        return btn
    }()
    
    private lazy var criticalTab: UITabBarItem = {
        var btn = UITabBarItem(title: "CRITICAL", image: nil, tag: 1)
        return btn
    }()
    
    private lazy var endangeredTab: UITabBarItem = {
        var btn = UITabBarItem(title: "ENDANGERED", image: nil, tag: 2)
        return btn
    }()
    
    private lazy var vulnerableTab: UITabBarItem = {
        var btn = UITabBarItem(title: "VULNERABLE", image: nil, tag: 3)
        return btn
    }()
    
    //MARK: -- Properties
    
    let appearance = UITabBarAppearance()
    
    //MARK: -- Methods

    private func setAppearance() {
        if #available(iOS 13, *) {
            
            appearance.backgroundColor = .black
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .black
    
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: FontWeight.light.rawValue, size: 12.deviceScaled)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)

            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: FontWeight.regular.rawValue, size: 13.deviceScaled)!]
            appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
            
            standardAppearance = appearance
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        items = [allTab, criticalTab, endangeredTab, vulnerableTab]
        setAppearance()
        
        selectionIndicatorImage = UIImage().createSelectionIndicator(color: .white, size: CGSize(width: frame.width/CGFloat(items!.count), height: frame.height), lineWidth: 2.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

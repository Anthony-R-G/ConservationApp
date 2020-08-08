//
//  Utilities.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class Factory {
    
    static func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.register(SpeciesCollectionViewCell.self, forCellWithReuseIdentifier: "speciesCell")
        return collectionView
    }
    
    static func makeLabel(title: String?,
                          weight: FontWeight,
                          size: CGFloat,
                          color: UIColor,
                          alignment: NSTextAlignment) -> UILabel {
        
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: weight.rawValue, size: size)
        label.textAlignment = alignment
        label.textColor = color
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }
    
    static func makeToolBarButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(Constants.buttonColor, for: .selected)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.sizeToFit()
        return button
    }
    
    static func makeButton(title: String, weight: FontWeight, color: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: weight.rawValue, size: 15)
        return button
    }
    
    static func makeRoundedInfoView(strategy: SpeciesStrategy) -> RoundedInfoView {
        let view = RoundedInfoView(frame: CGRect(), speciesStrategy: strategy)
        return view
    }
}


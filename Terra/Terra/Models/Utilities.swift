//
//  Utilities.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class Utilities {
    
    static func makeCollectionView(superView: UIView) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: superView.frame.width, height: 0), collectionViewLayout: layout)
        
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
    
    static func makeBottomBarButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9257398248, green: 1, blue: 0.7623538375, alpha: 1), for: .selected)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.sizeToFit()
        return button
    }
    
    static func makeRoundedInfoView(strategy: SpeciesStrategy
                                    ) -> RoundedInfoView {
        let view = RoundedInfoView(frame: CGRect(), strategy: strategy)
        return view
    }
}


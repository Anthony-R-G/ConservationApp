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
    
    static func makeLabel(title: String?, weight: FontWeight, size: CGFloat, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: weight.rawValue, size: size)
        label.textAlignment = alignment
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }
    
    static func makeBottomBarButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .selected)
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.sizeToFit()
        return button
    }
}


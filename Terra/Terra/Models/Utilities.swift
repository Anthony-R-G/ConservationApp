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
        label.sizeToFit()
        return label
    }
    
}


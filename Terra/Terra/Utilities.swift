//
//  Utilities.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func makeCollectionView(parentView: UIView) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: parentView.frame.width, height: 0), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(SpeciesCollectionViewCell.self, forCellWithReuseIdentifier: "speciesCell")
        return collectionView
    }
}

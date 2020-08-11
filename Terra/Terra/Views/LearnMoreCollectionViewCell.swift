//
//  LearnMoreCollectionViewCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/11/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class LearnMoreCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.115292646, green: 0.1146147624, blue: 0.1158185378, alpha: 0.5930276113)
        layer.cornerRadius = 39
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

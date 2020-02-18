//
//  SpeciesCollectionViewCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/29/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class SpeciesCollectionViewCell: UICollectionViewCell {
    
    lazy var speciesNameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var speciesImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var textShadow: GradientView = {
        let gv = GradientView()
        return gv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Constraints
extension SpeciesCollectionViewCell {
    
    private func setConstraints(){
        [speciesNameLabel, speciesImage].forEach{addSubview($0)}
        [speciesNameLabel, speciesImage].forEach{$0.translatesAutoresizingMaskIntoConstraints = false }
        
        setSpeciesImageConstraints()
        setSpeciesNameLabelConstraints()
    }
    
 
    private func setSpeciesImageConstraints() {
        NSLayoutConstraint.activate([
            speciesImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            speciesImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            speciesImage.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            speciesImage.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    private func setSpeciesNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            speciesNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            speciesNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
            speciesNameLabel.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
}

//
//  SpeciesCollectionViewCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/29/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import Kingfisher

class SpeciesCollectionViewCell: UICollectionViewCell {
    
    lazy var speciesNameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textAlignment = .left
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
    
    func configureCell(from species: Species) {
        speciesNameLabel.text = species.commonName
        let imageURL = URL(string: species.cellImage)
        speciesImage.kf.setImage(with: imageURL)
        speciesImage.kf.indicatorType = .activity
        backgroundColor = species.habitatSystem == .marine ? #colorLiteral(red: 0.2312238216, green: 0.3822638988, blue: 0.7663728595, alpha: 1) : #colorLiteral(red: 0.8971922994, green: 0.4322043657, blue: 0.1033880934, alpha: 1)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        setConstraints()
        
        
        
        let backgroundOverlay = GradientView(frame: self.contentView.bounds)
        backgroundOverlay.startColor = .clear
        backgroundOverlay.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.6547784675)
        self.insertSubview(speciesImage, at: 0)
        self.insertSubview(backgroundOverlay, at: 1)
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
    
    private func setSpeciesNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            speciesNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            speciesNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
            speciesNameLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    private func setSpeciesImageConstraints() {
        NSLayoutConstraint.activate([
            speciesImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            speciesImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            speciesImage.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            speciesImage.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}

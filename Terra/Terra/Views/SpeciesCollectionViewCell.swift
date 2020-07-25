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
    //MARK: -- UI Element Initialization
    
    private lazy var speciesNameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 23)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.startColor = .clear
        gv.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.6547784675)
        insertSubview(gv, at: 1)
        return gv
    }()
    
    //MARK: -- Methods
    
    public func configureCellUI(from species: Species) {
        speciesNameLabel.text = species.commonName
        let imageURL = URL(string: species.cellImage)
        backgroundImage.kf.setImage(with: imageURL)
        backgroundImage.kf.indicatorType = .activity
        
        backgroundColor = species.habitatSystem == .marine ? #colorLiteral(red: 0.2312238216, green: 0.3822638988, blue: 0.7663728595, alpha: 1) : #colorLiteral(red: 0.8971922994, green: 0.4322043657, blue: 0.1033880934, alpha: 1)
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Adding Subviews & Constraints

extension SpeciesCollectionViewCell {
    private func addSubviews() {
        let UIElements = [backgroundImage, backgroundGradientOverlay, speciesNameLabel]
        UIElements.forEach{ contentView.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setBackgroundImageConstraints()
        setBackgroundGradientOverlayConstraints()
        setSpeciesNameLabelConstraints()
    }
    
    private func setBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    private func setBackgroundGradientOverlayConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientOverlay.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backgroundGradientOverlay.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backgroundGradientOverlay.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            backgroundGradientOverlay.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    private func setSpeciesNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            speciesNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            speciesNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
            speciesNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

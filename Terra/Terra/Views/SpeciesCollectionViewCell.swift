//
//  SpeciesCollectionViewCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/29/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import FirebaseUI

class SpeciesCollectionViewCell: UICollectionViewCell {
    //MARK: -- UI Element Initialization
    
    private lazy var speciesNameLabel: UILabel = {
        return Utilities.makeLabel(title: nil,
                                   weight: .bold,
                                   size: 23,
                                   color: .white,
                                   alignment: .left)
    }()
    
    private lazy var backgroundImageView: UIImageView = {
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
        FirebaseStorageService.cellImageManager.getImage(imageRefStr: species.commonName, imageView: backgroundImageView)
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

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesCollectionViewCell {
    func addSubviews() {
        let UIElements = [backgroundImageView, backgroundGradientOverlay, speciesNameLabel]
        UIElements.forEach{ contentView.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setBackgroundImageConstraints()
        setBackgroundGradientOverlayConstraints()
        setSpeciesNameLabelConstraints()
    }
    
    func setBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    func setBackgroundGradientOverlayConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientOverlay.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backgroundGradientOverlay.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backgroundGradientOverlay.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            backgroundGradientOverlay.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    func setSpeciesNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            speciesNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            speciesNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
            speciesNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

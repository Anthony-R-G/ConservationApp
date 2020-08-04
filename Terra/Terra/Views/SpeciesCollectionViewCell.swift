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
        let label = Factory.makeLabel(title: nil,
                                   weight: .medium,
                                   size: 27,
                                   color: .white,
                                   alignment: .left)
        label.numberOfLines = 0
        return label
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
        FirebaseStorageService.cellImageManager.getImage(for: species.commonName, setTo: backgroundImageView)
//        layer.cornerRadius = Constants.cornerRadius
//        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        // cell rounded section
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        // cell shadow section
        self.contentView.layer.cornerRadius = 20.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
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
            speciesNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            speciesNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            speciesNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.70),
            speciesNameLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}

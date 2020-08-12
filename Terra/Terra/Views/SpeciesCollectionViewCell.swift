//
//  SpeciesCollectionViewCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/29/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import FirebaseUI

final class SpeciesCollectionViewCell: UICollectionViewCell {
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
    
    private lazy var speciesScientificNameLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      weight: .lightItalic,
                                      size: 16,
                                      color: .white,
                                      alignment: .left)
        return label
    }()
    
    private lazy var conservationStatusLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      weight: .bold,
                                      size: 16,
                                      color: .white,
                                      alignment: .center)
        label.layer.cornerRadius = 10
        label.backgroundColor = Constants.red
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var populationNumbersLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      weight: .medium,
                                      size: 18,
                                      color: .white,
                                      alignment: .left)
        return label
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.startColor = .clear
        gv.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.7227097603)
        gv.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(gv, at: 1)
        return gv
    }()
    
    //MARK: -- Methods
    
    public func configureCellUI(from species: Species) {
        FirebaseStorageService.cellImageManager.getImage(for: species.commonName, setTo: backgroundImageView)
        speciesNameLabel.text = species.commonName
        speciesScientificNameLabel.text = species.taxonomy.scientificName
        populationNumbersLabel.text = species.population.numbers.replacingOccurrences(of: "~", with: "")
        
        switch species.population.conservationStatus {
        case .critical: conservationStatusLabel.text = "CR"
        case .endangered: conservationStatusLabel.text = "EN"
        case .vulnerable: conservationStatusLabel.text = "VU"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesCollectionViewCell {
    func addSubviews() {
        let UIElements = [speciesNameLabel, conservationStatusLabel, populationNumbersLabel, speciesScientificNameLabel]
        UIElements.forEach{ contentView.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setBackgroundImageConstraints()
        setBackgroundGradientOverlayConstraints()
        setSpeciesNameLabelConstraints()
        setConservationStatusLabelConstraints()
        setSpeciesScientificNameLabelConstraints()
        setPopulationNumbersLabelConstraints()
    }
    
    func setBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setBackgroundGradientOverlayConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientOverlay.heightAnchor.constraint(equalTo: heightAnchor, constant: 30),
            backgroundGradientOverlay.widthAnchor.constraint(equalTo: widthAnchor),
            
        ])
    }
    
    func setSpeciesNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.universalLeadingConstant),
            speciesNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            speciesNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.80),
            speciesNameLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func setSpeciesScientificNameLabelConstraints() {
        NSLayoutConstraint.activate([
            speciesScientificNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            speciesScientificNameLabel.leadingAnchor.constraint(equalTo: speciesNameLabel.leadingAnchor),
            speciesScientificNameLabel.heightAnchor.constraint(equalToConstant: 50),
            speciesScientificNameLabel.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    func setConservationStatusLabelConstraints() {
        NSLayoutConstraint.activate([
            conservationStatusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            conservationStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            conservationStatusLabel.heightAnchor.constraint(equalToConstant: 40),
            conservationStatusLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setPopulationNumbersLabelConstraints() {
        NSLayoutConstraint.activate([
            populationNumbersLabel.trailingAnchor.constraint(equalTo: conservationStatusLabel.leadingAnchor, constant: -10),
            populationNumbersLabel.centerYAnchor.constraint(equalTo: conservationStatusLabel.centerYAnchor),
            populationNumbersLabel.widthAnchor.constraint(equalToConstant: 50),
            populationNumbersLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

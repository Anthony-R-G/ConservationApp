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
                                      weight: .regular,
                                      size: 16,
                                      color: .white,
                                      alignment: .right)
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
    
    public func configureCell(from species: Species) {
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
        clipsToBounds = true
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
        let UIElements = [speciesNameLabel, conservationStatusLabel, populationNumbersLabel, speciesScientificNameLabel]
        UIElements.forEach{ contentView.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setBackgroundImageConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setSpeciesNameLabelConstraints()
        setSpeciesScientificNameLabelConstraints()
        
        setConservationStatusLabelConstraints()
        setPopulationNumbersLabelConstraints()
    }
    
    func setBackgroundImageConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setBackgroundGradientOverlayConstraints() {
        backgroundGradientOverlay.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setSpeciesNameLabelConstraints(){
        speciesNameLabel.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview().inset(Constants.spacingConstant)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(90)
        }
    }
    
    func setSpeciesScientificNameLabelConstraints() {
        speciesScientificNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(speciesNameLabel)
            make.trailing.equalTo(populationNumbersLabel.snp.leading)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
    
    func setConservationStatusLabelConstraints() {
        conservationStatusLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(speciesScientificNameLabel)
            make.trailing.equalToSuperview().inset(10)
            make.height.width.equalTo(40)
        }
    }
    
    func setPopulationNumbersLabelConstraints() {
        populationNumbersLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(conservationStatusLabel.snp.leading).inset(-10)
            make.centerY.equalTo(conservationStatusLabel)
            make.height.width.equalTo(50)
        }
    }
}

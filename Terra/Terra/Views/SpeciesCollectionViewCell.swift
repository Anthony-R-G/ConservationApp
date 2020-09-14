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
    
    private lazy var speciesCommonNameLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      fontWeight: .bold,
                                      fontSize: Constants.FontHierarchy.primaryContentFontSize,
                                      widthAdjustsFontSize: true,
                                      color: .white,
                                      alignment: .left)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var speciesScientificNameLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 fontWeight: .lightItalic,
                                 fontSize: Constants.FontHierarchy.secondaryContentFontSize,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var conservationStatusLabel: UILabel = {
        let label = UILabel(frame: CGRect(origin: .zero, size: Constants.buttonSizeRegular))
        label.font = UIFont(name: FontWeight.bold.rawValue,
                            size: Constants.FontHierarchy.secondaryContentFontSize)
        label.textAlignment = .center
        label.layer.cornerRadius = 0.5 * label.bounds.size.width
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var populationNumbersLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 fontWeight: .regular,
                                 fontSize: Constants.FontHierarchy.secondaryContentFontSize,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .right)
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.startColor = .clear
        gv.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.7227097603)
        return gv
    }()
    
    //MARK: -- Methods
    
    public func configureCell(from species: Species) {
        FirebaseStorageService.cellImageManager.getImage(for: species.commonName, setTo: backgroundImageView)
        speciesCommonNameLabel.text = species.commonName
        speciesScientificNameLabel.text = species.taxonomy.scientificName
        populationNumbersLabel.text = species.population.numbers.replacingOccurrences(of: "~", with: "")
        
        switch species.population.conservationStatus {
        case .critical:
            conservationStatusLabel.text = "CR"
            conservationStatusLabel.backgroundColor = Constants.Color.criticalStatusColor
            conservationStatusLabel.textColor = #colorLiteral(red: 0.997191608, green: 0.8045830131, blue: 0.8038765788, alpha: 1)
            
        case .endangered:
            conservationStatusLabel.text = "EN"
            conservationStatusLabel.backgroundColor = Constants.Color.endangeredStatusColor
            conservationStatusLabel.textColor = #colorLiteral(red: 1, green: 0.8029765487, blue: 0.6047396064, alpha: 1)
            
        case .vulnerable:
            conservationStatusLabel.text = "VU"
            conservationStatusLabel.backgroundColor = Constants.Color.vulnerableStatusColor
            conservationStatusLabel.textColor = #colorLiteral(red: 0.9976391196, green: 0.998760879, blue: 0.8034237027, alpha: 1)
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
        [backgroundImageView, backgroundGradientOverlay, speciesCommonNameLabel, conservationStatusLabel, populationNumbersLabel, speciesScientificNameLabel]
            .forEach{ contentView.addSubview($0) }
    }
    
    func setConstraints() {
        setBackgroundImageConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setSpeciesCommonNameLabelConstraints()
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
    
    func setSpeciesCommonNameLabelConstraints(){
        speciesCommonNameLabel.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview().inset(Constants.padding)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(90)
        }
    }
    
    func setSpeciesScientificNameLabelConstraints() {
        speciesScientificNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(speciesCommonNameLabel)
            make.trailing.equalTo(populationNumbersLabel.snp.leading)
            make.bottom.equalToSuperview().inset(Constants.padding/2)
            make.height.equalTo(50)
        }
    }
    
    func setConservationStatusLabelConstraints() {
        conservationStatusLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(speciesScientificNameLabel)
            make.trailing.equalToSuperview().inset(Constants.padding)
            make.height.width.equalTo(conservationStatusLabel.frame.size)
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

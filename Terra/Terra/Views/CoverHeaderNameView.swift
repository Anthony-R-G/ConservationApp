//
//  HeaderNameView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class CoverHeaderNameView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var conservationStatusButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: FontWeight.regular.rawValue, size: 16.deviceScaled)
        button.setTitle(species.population.conservationStatus.rawValue.uppercased(), for: .normal)
        
        switch species.population.conservationStatus {
        case .critical:
            button.layer.borderColor = Constants.Color.criticalStatusColor.cgColor
            
        case .endangered:
            button.layer.borderColor = Constants.Color.endangeredStatusColor.cgColor
            
            
        case .vulnerable:
            button.layer.borderColor = Constants.Color.vulnerableStatusColor.cgColor
            
        }
        
        button.layer.borderWidth = Constants.borderWidth
        button.layer.cornerRadius = 15
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }()
    
    
    
    private lazy var speciesCommonNameLabel: UILabel = {
        let label = Factory.makeLabel(title: species.commonName,
                                      weight: .bold,
                                      size: 56,
                                      color: .white,
                                      alignment: .left)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var speciesScientificNameLabel: UILabel = {
        return Factory.makeLabel(title: "— \(species.taxonomy.scientificName)",
            weight: .lightItalic,
            size: 17,
            color: .white,
            alignment: .left)
    }()
    
 
    
    
    //MARK: -- Properties
    
    weak var delegate: ConservationStatusDelegate?
    
    var species: Species!
    
    //MARK: -- Methods
    
    @objc private func handleTap() {
        delegate?.conservationStatusTapped()
    }
    
    func shrinkCommonNameLabel() {
        speciesCommonNameLabel.animateToFont(
            UIFont(
                name: FontWeight.bold.rawValue,
                size: Constants.screenHeight * 0.04352678571428571)!,
            withDuration: 0.5)
    }
    
    func enlargeCommonNameLabel() {
        speciesCommonNameLabel.animateToFont(
            UIFont(
                name: FontWeight.bold.rawValue,
                size: 56.deviceScaled)!,
            withDuration: 1.3)
    }
    
    required init(species: Species, delegate: ConservationStatusDelegate) {
        self.species = species
        self.delegate = delegate
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension CoverHeaderNameView {
    
    func addSubviews() {
        [conservationStatusButton, speciesCommonNameLabel, speciesScientificNameLabel].forEach { addSubview($0) }
    }
    
    func setConstraints() {
       setConservationStatusButtonConstraints()
        setSpeciesCommonNameLabelConstraints()
        setSpeciesScientificNameLabelConstraints()
    }
    
    func setConservationStatusButtonConstraints() {
        conservationStatusButton.snp.makeConstraints { (make) in
            make.leading.equalTo(speciesCommonNameLabel).inset(5)
            make.bottom.equalTo(speciesCommonNameLabel.snp.top).inset(-10)
            make.height.equalTo(30.deviceScaled)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
    }

    func setSpeciesCommonNameLabelConstraints(){
        speciesCommonNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.bottom.equalTo(speciesScientificNameLabel.snp.top)
            make.width.equalToSuperview().multipliedBy(0.80)
        }
    }
    
    func setSpeciesScientificNameLabelConstraints() {
        speciesScientificNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(speciesCommonNameLabel.snp.leading)
            make.bottom.equalToSuperview()
        }
    } 
}

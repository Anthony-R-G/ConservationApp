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
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 17.deviceAdjusted)
        button.layer.borderColor = Constants.red.cgColor
        button.layer.borderWidth = Constants.borderWidth
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }()
    
     private lazy var speciesCommonNameLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                        weight: .bold,
                                        size: 56,
                                        color: .white,
                                        alignment: .left)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var speciesScientificNameLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                        weight: .lightItalic,
                                        size: 17,
                                        color: .white,
                                        alignment: .left)
    }()
    
    
    //MARK: -- Properties
    
    weak var delegate: ConservationStatusDelegate?
    
    //MARK: -- Methods
    
    @objc private func handleTap() {
        delegate?.conservationStatusTapped()
    }
    
    public func configureView(from species: Species) {
        conservationStatusButton.setTitle(species.population.conservationStatus.rawValue, for: .normal)
        speciesCommonNameLabel.text = species.commonName
        speciesScientificNameLabel.text = "— \(species.taxonomy.scientificName)"
    }
        
    func shrinkCommonNameLabel() {
        speciesCommonNameLabel.animateToFont(UIFont(name: "Roboto-Bold", size: 39.deviceAdjusted)!, withDuration: 0.5)
    }
    
    func expandCommonNameLabel() {
        speciesCommonNameLabel.animateToFont(UIFont(name: "Roboto-Bold", size: 56.deviceAdjusted)!, withDuration: 1.3)
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

fileprivate extension CoverHeaderNameView {
    
    func addSubviews() {
        let UIElements = [conservationStatusButton, speciesCommonNameLabel, speciesScientificNameLabel]
        UIElements.forEach { addSubview($0) }
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
            make.height.equalTo(25.deviceAdjusted)
            make.width.equalToSuperview().multipliedBy(0.3)
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

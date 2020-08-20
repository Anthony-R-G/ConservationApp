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
    
    private lazy var conservationStatusLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                        weight: .regular,
                                        size: 17,
                                        color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                        alignment: .center)
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = Constants.borderWidth
        label.layer.cornerRadius = 10
        return label
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
        let label = Factory.makeLabel(title: nil,
                                        weight: .lightItalic,
                                        size: 17,
                                        color: .white,
                                        alignment: .left)
        let neededSize = label.sizeThatFits(CGSize(width: frame.size.width,
                                                   height: CGFloat.greatestFiniteMagnitude))
        return label
    }()
    
    //MARK: -- Methods
    public func configureView(from species: Species) {
        conservationStatusLabel.text = species.population.conservationStatus.rawValue
        speciesCommonNameLabel.text = species.commonName
        speciesScientificNameLabel.text = "— \(species.taxonomy.scientificName)"
    }
        
    func shrinkCommonNameLabel() {
        speciesCommonNameLabel.animateToFont(UIFont(name: "Roboto-Bold", size: 40)!, withDuration: 0.5)
    }
    
    func expandCommonNameLabel() {
         speciesCommonNameLabel.animateToFont(UIFont(name: "Roboto-Bold", size: 56)!, withDuration: 0.5)
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
        let UIElements = [conservationStatusLabel, speciesCommonNameLabel, speciesScientificNameLabel]
        UIElements.forEach { addSubview($0) }
    }
    
    func setConstraints() {
        setConservationStatusLabelConstraints()
        setSpeciesCommonNameLabelConstraints()
        setSpeciesScientificNameLabelConstraints()
    }
    
    func setConservationStatusLabelConstraints() {
        conservationStatusLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(speciesCommonNameLabel).inset(5)
            make.bottom.equalTo(speciesCommonNameLabel.snp.top).inset(-10)
            make.height.equalTo(25)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    func setSpeciesCommonNameLabelConstraints(){
        speciesCommonNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.bottom.equalTo(speciesScientificNameLabel.snp.top)
            make.width.equalToSuperview().multipliedBy(0.76)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    func setSpeciesScientificNameLabelConstraints() {
        speciesScientificNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(speciesCommonNameLabel.snp.leading)
            make.bottom.equalToSuperview()
        }
    } 
}

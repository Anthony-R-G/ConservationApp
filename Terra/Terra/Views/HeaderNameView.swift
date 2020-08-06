//
//  HeaderNameView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class HeaderNameView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var conservationStatusLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                        weight: .regular,
                                        size: 17,
                                        color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                        alignment: .center)
        label.backgroundColor = .clear
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
    public func setViewElementsFromSpeciesData(species: Species) {
        conservationStatusLabel.text = species.population.conservationStatus.rawValue
        speciesCommonNameLabel.text = species.commonName
        speciesScientificNameLabel.text = "— \(species.taxonomy.scientificName)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension HeaderNameView {
    
    func addSubviews() {
        let UIElements = [conservationStatusLabel, speciesCommonNameLabel, speciesScientificNameLabel]
        UIElements.forEach { addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    func setConstraints() {
        setConservationStatusLabelConstraints()
        setSpeciesCommonNameLabelConstraints()
        setSpeciesScientificNameLabelConstraints()
    }
    
    func setConservationStatusLabelConstraints() {
        NSLayoutConstraint.activate([
            conservationStatusLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor, constant: 5),
            conservationStatusLabel.bottomAnchor.constraint(equalTo: speciesCommonNameLabel.topAnchor, constant: -10),
            conservationStatusLabel.heightAnchor.constraint(equalToConstant: 25),
            conservationStatusLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
        ])
    }
    
    func setSpeciesCommonNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesCommonNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            speciesCommonNameLabel.bottomAnchor.constraint(equalTo: speciesScientificNameLabel.topAnchor),
            speciesCommonNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.76),
            speciesCommonNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    func setSpeciesScientificNameLabelConstraints() {
        NSLayoutConstraint.activate([
            speciesScientificNameLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor),
            speciesScientificNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    } 
}

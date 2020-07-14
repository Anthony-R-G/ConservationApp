//
//  BasicInfoView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class BasicInfoView: UIView {
    lazy var conservationStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.backgroundColor = #colorLiteral(red: 0.6787196398, green: 0.2409698367, blue: 0.261569947, alpha: 0.8461579623)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    lazy var speciesCommonNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 55)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    lazy var speciesScientificNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var weightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weightLabel, weightInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Weight"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var weightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var heightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heightLabel, heightInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Height"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var heightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var numbersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numbersLabel, numbersInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var numbersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Numbers"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var numbersInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
        
    }()
    
    func setUIFromSpecies(species: Species) {
        speciesCommonNameLabel.text = species.commonName
        speciesScientificNameLabel.text = "— \(species.scientificName)"
        numbersInfoLabel.text = species.populationNumbers
        conservationStatusLabel.text = species.conservationStatus.rawValue
        weightInfoLabel.text = species.weight
        heightInfoLabel.text = species.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//Constraints
extension BasicInfoView {
    
    private func setConservationStatusLabelConstraints() {
        NSLayoutConstraint.activate([
            conservationStatusLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor),
            conservationStatusLabel.bottomAnchor.constraint(equalTo: speciesCommonNameLabel.topAnchor, constant: -10),
            conservationStatusLabel.heightAnchor.constraint(equalToConstant: 30),
            conservationStatusLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    
    private func setSpeciesCommonNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesCommonNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            speciesCommonNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            speciesCommonNameLabel.widthAnchor.constraint(equalToConstant: 300),
            speciesCommonNameLabel.heightAnchor.constraint(equalToConstant: 145)
        ])
    }
    
    private func setSpeciesScientificNameLabelConstraints() {
        NSLayoutConstraint.activate([
            speciesScientificNameLabel.topAnchor.constraint(equalTo: speciesCommonNameLabel.bottomAnchor),
            speciesScientificNameLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor),
            speciesScientificNameLabel.heightAnchor.constraint(equalToConstant: 30),
            speciesScientificNameLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setNumbersStackConstraints(){
        NSLayoutConstraint.activate([
            numbersStackView.topAnchor.constraint(equalTo: speciesScientificNameLabel.bottomAnchor, constant: 15),
            numbersStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numbersStackView.heightAnchor.constraint(equalToConstant: 50),
            numbersStackView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setWeightStackConstraints() {
        NSLayoutConstraint.activate([
            weightStackView.topAnchor.constraint(equalTo: numbersStackView.topAnchor),
            weightStackView.leadingAnchor.constraint(equalTo: numbersStackView.trailingAnchor, constant: 25),
            weightStackView.heightAnchor.constraint(equalTo: numbersStackView.heightAnchor),
            weightStackView.widthAnchor.constraint(equalTo: numbersStackView.widthAnchor)
        ])
    }
    
    private func setHeightStackConstraints() {
        NSLayoutConstraint.activate([
            heightStackView.topAnchor.constraint(equalTo: numbersStackView.topAnchor),
            heightStackView.leadingAnchor.constraint(equalTo: weightStackView.trailingAnchor, constant: 25),
            heightStackView.heightAnchor.constraint(equalTo: numbersStackView.heightAnchor),
            heightStackView.widthAnchor.constraint(equalTo: numbersStackView.widthAnchor)
        ])
    }
    
    
    private func setConstraints() {
        let UIElements = [speciesCommonNameLabel, speciesScientificNameLabel, conservationStatusLabel, numbersStackView, weightStackView, heightStackView]
        UIElements.forEach{ self.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        setConservationStatusLabelConstraints()
        setSpeciesCommonNameLabelConstraints()
        setSpeciesScientificNameLabelConstraints()
        setNumbersStackConstraints()
        setWeightStackConstraints()
        setHeightStackConstraints()
    }
}

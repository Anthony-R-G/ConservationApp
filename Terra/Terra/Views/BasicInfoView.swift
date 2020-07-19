//
//  BasicInfoView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class BasicInfoView: UIView {
    private lazy var conservationStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 17)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.backgroundColor = #colorLiteral(red: 0.6787196398, green: 0.2409698367, blue: 0.261569947, alpha: 0.8461579623)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var speciesCommonNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 55)
        label.textColor = .white
        label.textAlignment = .left
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        //        let maxLabelWidth: CGFloat = 100
        //        let neededSize = label.sizeThatFits(CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        label.sizeToFit()
        return label
    }()
    
    private lazy var speciesScientificNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Light", size: 17)
        label.textColor = .white
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var numbersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numbersLabel, numbersInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var numbersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Numbers"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var numbersInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        label.backgroundColor = .clear
        return label
        
    }()
    
    private lazy var weightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weightLabel, weightInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Weight"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        return label
    }()
    
    private lazy var weightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        return label
    }()
    
    private lazy var heightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heightLabel, heightInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Height"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        return label
    }()
    
    private lazy var heightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        return label
    }()
    
    
    
    public func setViewElementsFromSpeciesData(species: Species) {
        conservationStatusLabel.text = species.conservationStatus.rawValue
        speciesCommonNameLabel.text = species.commonName
        speciesScientificNameLabel.text = "— \(species.scientificName)"
        numbersInfoLabel.text = species.populationNumbers
        weightInfoLabel.text = species.weight
        heightInfoLabel.text = species.height
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

//Constraints
extension BasicInfoView {
    
    private func addSubviews() {
        let UIElements = [speciesCommonNameLabel, speciesScientificNameLabel, numbersStackView, weightStackView, heightStackView]
        UIElements.forEach { self.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    private func setConstraints() {
        
        
        //          setConservationStatusLabelConstraints()
        setSpeciesCommonNameLabelConstraints()
        setSpeciesScientificNameLabelConstraints()
        setNumbersStackConstraints()
        setWeightStackConstraints()
        setHeightStackConstraints()
    }
    
    private func setConservationStatusLabelConstraints() {
        NSLayoutConstraint.activate([
            conservationStatusLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor, constant: 5),
            conservationStatusLabel.bottomAnchor.constraint(equalTo: speciesCommonNameLabel.topAnchor, constant: -10),
            conservationStatusLabel.heightAnchor.constraint(equalToConstant: 30),
            conservationStatusLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    
    private func setSpeciesCommonNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesCommonNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            speciesCommonNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            speciesCommonNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            speciesCommonNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setSpeciesScientificNameLabelConstraints() {
        NSLayoutConstraint.activate([
            speciesScientificNameLabel.topAnchor.constraint(equalTo: speciesCommonNameLabel.bottomAnchor),
            speciesScientificNameLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor),
            speciesScientificNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            speciesScientificNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func setNumbersStackConstraints(){
        NSLayoutConstraint.activate([
            numbersStackView.topAnchor.constraint(equalTo: speciesScientificNameLabel.bottomAnchor, constant: 15),
            numbersStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numbersStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3 ),
            numbersStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
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
}

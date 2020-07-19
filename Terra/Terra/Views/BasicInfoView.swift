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
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var speciesScientificNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Light", size: 17)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = .red
        label.adjustsFontSizeToFitWidth = true
        let neededSize = label.sizeThatFits(CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        label.sizeToFit()
        return label
    }()
    
   
    public func setViewElementsFromSpeciesData(species: Species) {
        conservationStatusLabel.text = species.conservationStatus.rawValue
        speciesCommonNameLabel.text = species.commonName
        speciesScientificNameLabel.text = "— \(species.scientificName)"
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
        let UIElements = [conservationStatusLabel, speciesCommonNameLabel, speciesScientificNameLabel]
        UIElements.forEach { self.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    private func setConstraints() {
        setConservationStatusLabelConstraints()
        setSpeciesCommonNameLabelConstraints()
        setSpeciesScientificNameLabelConstraints()
    }
    
    private func setConservationStatusLabelConstraints() {
        NSLayoutConstraint.activate([
            conservationStatusLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor, constant: 5),
            conservationStatusLabel.bottomAnchor.constraint(equalTo: speciesCommonNameLabel.topAnchor, constant: -10),
            conservationStatusLabel.heightAnchor.constraint(equalToConstant: 30),
            conservationStatusLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ])
    }
    
    private func setSpeciesCommonNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesCommonNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            speciesCommonNameLabel.bottomAnchor.constraint(equalTo: speciesScientificNameLabel.topAnchor),
            speciesCommonNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            speciesCommonNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setSpeciesScientificNameLabelConstraints() {
        NSLayoutConstraint.activate([
            speciesScientificNameLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor),
            speciesScientificNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            //            speciesScientificNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
//            speciesScientificNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
        ])
    }
}

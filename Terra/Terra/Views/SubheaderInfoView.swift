//
//  HeaderStacksView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/18/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class SubheaderInfoView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var numbersTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Numbers"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Light", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var numbersInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var weightTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Weight"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Light", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var weightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var heightTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Weight"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Light", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var heightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    //MARK: -- Methods
    public func setViewElementsFromSpeciesData(species: Species) {
        numbersInfoLabel.text = species.populationNumbers
        weightInfoLabel.text = species.weight
        heightInfoLabel.text = species.height
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

//MARK: -- Adding Subviews & Constraints

extension SubheaderInfoView {
    
    private func addSubviews() {
        let UIElements = [numbersTitleLabel, numbersInfoLabel, weightTitleLabel, weightInfoLabel, heightTitleLabel, heightInfoLabel]
        UIElements.forEach { self.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setNumbersTitleLabelConstraints()
        setNumbersInfoLabelConstraints()
        setWeightTitleLabelConstraints()
        setWeightInfoLabelConstraints()
        setHeightTitleLabelConstraints()
        setHeightInfoLabelConstraints()
    }
    
    private func setNumbersTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            numbersTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numbersTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            numbersTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            numbersTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
    }
    
    private func setNumbersInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            numbersInfoLabel.leadingAnchor.constraint(equalTo: numbersTitleLabel.leadingAnchor),
            numbersInfoLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            numbersInfoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            numbersInfoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
    
    private func setWeightTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            weightTitleLabel.leadingAnchor.constraint(equalTo: numbersTitleLabel.trailingAnchor, constant: 20),
            weightTitleLabel.topAnchor.constraint(equalTo: numbersTitleLabel.topAnchor),
            weightTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            weightTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
    }
    
    private func setWeightInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            weightInfoLabel.leadingAnchor.constraint(equalTo: weightTitleLabel.leadingAnchor),
            weightInfoLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            weightInfoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            weightInfoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
    
    private func setHeightTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            heightTitleLabel.leadingAnchor.constraint(equalTo: weightTitleLabel.trailingAnchor, constant: 20),
            heightTitleLabel.topAnchor.constraint(equalTo: numbersTitleLabel.topAnchor),
            heightTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            heightTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
    }
    
    private func setHeightInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            heightInfoLabel.leadingAnchor.constraint(equalTo: self.heightTitleLabel.leadingAnchor),
            heightInfoLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            heightInfoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            heightInfoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
}

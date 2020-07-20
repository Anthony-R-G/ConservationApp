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
    
    private lazy var numbersTrendLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Trend"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Light", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var numbersTrendInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var lastAssessedTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Last Assessed"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Light", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var lastAssessedInfoLabel: UILabel = {
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
        numbersTrendInfoLabel.text = species.populationTrend
        lastAssessedInfoLabel.text = species.assessmentDate
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
        let UIElements = [numbersTitleLabel, numbersInfoLabel, numbersTrendLabel, numbersTrendInfoLabel, lastAssessedTitleLabel, lastAssessedInfoLabel]
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
            numbersTrendLabel.leadingAnchor.constraint(equalTo: numbersTitleLabel.trailingAnchor, constant: 20),
            numbersTrendLabel.topAnchor.constraint(equalTo: numbersTitleLabel.topAnchor),
            numbersTrendLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            numbersTrendLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
    }
    
    private func setWeightInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            numbersTrendInfoLabel.leadingAnchor.constraint(equalTo: numbersTrendLabel.leadingAnchor),
            numbersTrendInfoLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            numbersTrendInfoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            numbersTrendInfoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
    
    private func setHeightTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            lastAssessedTitleLabel.leadingAnchor.constraint(equalTo: numbersTrendLabel.trailingAnchor, constant: 20),
            lastAssessedTitleLabel.topAnchor.constraint(equalTo: numbersTitleLabel.topAnchor),
            lastAssessedTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            lastAssessedTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
    }
    
    private func setHeightInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            lastAssessedInfoLabel.leadingAnchor.constraint(equalTo: self.lastAssessedTitleLabel.leadingAnchor),
            lastAssessedInfoLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            lastAssessedInfoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            lastAssessedInfoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
}

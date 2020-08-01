//
//  SubheaderInfoView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/18/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class SubheaderInfoView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var numbersTitleLabel: UILabel = {
        return Utilities.makeLabel(title: "Numbers",
                                   weight: .light,
                                   size: 16,
                                   color: .white,
                                   alignment: .left)
    }()
    
    private lazy var numbersDataLabel: UILabel = {
        return Utilities.makeLabel(title: nil,
                                   weight: .medium,
                                   size: 18,
                                   color: .white,
                                   alignment: .left)
    }()
    
    private lazy var trendTitleLabel: UILabel = {
        return Utilities.makeLabel(title: "Trend",
                                   weight: .light,
                                   size: 16,
                                   color: .white,
                                   alignment: .left)
    }()
    
    private lazy var trendDataLabel: UILabel = {
        return Utilities.makeLabel(title: nil,
                                   weight: .medium,
                                   size: 18,
                                   color: .white,
                                   alignment: .left)
    }()
    
    private lazy var lastAssessedTitleLabel: UILabel = {
        return Utilities.makeLabel(title: "Last Assessed",
                                   weight: .light,
                                   size: 16,
                                   color: .white,
                                   alignment: .left)
    }()
    
    private lazy var lastAssessedDataLabel: UILabel = {
        return Utilities.makeLabel(title: nil,
                                   weight: .medium,
                                   size: 18,
                                   color: .white,
                                   alignment: .left)
    }()
    
    //MARK: -- Methods
    public func setViewElementsFromSpeciesData(species: Species) {
        numbersDataLabel.text = species.populationNumbers
        trendDataLabel.text = species.populationTrend.rawValue
        trendDataLabel.textColor = species.populationTrend == .recovering ?  #colorLiteral(red: 0.7970843911, green: 1, blue: 0.5273691416, alpha: 1) : #colorLiteral(red: 1, green: 0.5084088445, blue: 0.5854002237, alpha: 1)
        lastAssessedDataLabel.text = species.assessmentDate
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

fileprivate extension SubheaderInfoView {
    
    func addSubviews() {
        let UIElements = [numbersTitleLabel, numbersDataLabel, trendTitleLabel, trendDataLabel, lastAssessedTitleLabel, lastAssessedDataLabel]
        UIElements.forEach { self.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setNumbersTitleLabelConstraints()
        setNumbersInfoLabelConstraints()
        setWeightTitleLabelConstraints()
        setWeightInfoLabelConstraints()
        setHeightTitleLabelConstraints()
        setHeightInfoLabelConstraints()
    }
    
    func setNumbersTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            numbersTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numbersTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            numbersTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            numbersTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
    }
    
    func setNumbersInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            numbersDataLabel.leadingAnchor.constraint(equalTo: numbersTitleLabel.leadingAnchor),
            numbersDataLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            numbersDataLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            numbersDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
    
    func setWeightTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            trendTitleLabel.leadingAnchor.constraint(equalTo: numbersTitleLabel.trailingAnchor, constant: 20),
            trendTitleLabel.topAnchor.constraint(equalTo: numbersTitleLabel.topAnchor),
            trendTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            trendTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
    }
    
    func setWeightInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            trendDataLabel.leadingAnchor.constraint(equalTo: trendTitleLabel.leadingAnchor),
            trendDataLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            trendDataLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            trendDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
    
    func setHeightTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            lastAssessedTitleLabel.leadingAnchor.constraint(equalTo: trendTitleLabel.trailingAnchor, constant: 20),
            lastAssessedTitleLabel.topAnchor.constraint(equalTo: numbersTitleLabel.topAnchor),
            lastAssessedTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            lastAssessedTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
    }
    
    func setHeightInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            lastAssessedDataLabel.leadingAnchor.constraint(equalTo: self.lastAssessedTitleLabel.leadingAnchor),
            lastAssessedDataLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            lastAssessedDataLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            lastAssessedDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
}

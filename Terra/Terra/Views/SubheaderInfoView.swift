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
        numbersDataLabel.text = species.population.numbers
        trendDataLabel.text = species.population.trend.rawValue
        trendDataLabel.textColor = species.population.trend == .decreasing ? #colorLiteral(red: 1, green: 0.4507741928, blue: 0.5112823844, alpha: 1) : #colorLiteral(red: 0.7970843911, green: 1, blue: 0.5273691416, alpha: 1)
        lastAssessedDataLabel.text = "\(species.population.assessmentDate)"
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
        setNumbersDataLabelConstraints()
        setTrendTitleLabelConstraints()
        setTrendDataLabelConstraints()
        setLastAssessedTitleLabelConstraints()
        setLastAssessedDataLabelConstraints()
    }
    
    func setNumbersTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            numbersTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            numbersTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            numbersTitleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            numbersTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
        ])
    }
    
    func setNumbersDataLabelConstraints() {
        NSLayoutConstraint.activate([
            numbersDataLabel.leadingAnchor.constraint(equalTo: numbersTitleLabel.leadingAnchor),
            numbersDataLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            numbersDataLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            numbersDataLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10)
        ])
    }
    
    func setTrendTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            trendTitleLabel.leadingAnchor.constraint(equalTo: numbersTitleLabel.trailingAnchor, constant: Constants.universalLeadingConstant),
            trendTitleLabel.topAnchor.constraint(equalTo: numbersTitleLabel.topAnchor),
            trendTitleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            trendTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
        ])
    }
    
    func setTrendDataLabelConstraints() {
        NSLayoutConstraint.activate([
            trendDataLabel.leadingAnchor.constraint(equalTo: trendTitleLabel.leadingAnchor),
            trendDataLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            trendDataLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            trendDataLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10)
        ])
    }
    
    func setLastAssessedTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            lastAssessedTitleLabel.leadingAnchor.constraint(equalTo: trendTitleLabel.trailingAnchor, constant: Constants.universalLeadingConstant),
            lastAssessedTitleLabel.topAnchor.constraint(equalTo: numbersTitleLabel.topAnchor),
            lastAssessedTitleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            lastAssessedTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
    }
    
    func setLastAssessedDataLabelConstraints() {
        NSLayoutConstraint.activate([
            lastAssessedDataLabel.leadingAnchor.constraint(equalTo: lastAssessedTitleLabel.leadingAnchor),
            lastAssessedDataLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            lastAssessedDataLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            lastAssessedDataLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10)
        ])
    }
}

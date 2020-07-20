//
//  SpeciesOverviewView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/20/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class SpeciesOverviewView: UIView {
    //MARK: -- UI Element Initialization
    private lazy var overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "OVERVIEW"
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private lazy var summaryTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Roboto-Light", size: 17)
        tv.textColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        tv.backgroundColor = .clear
        tv.isEditable = false
        return tv
    }()
    
    private lazy var infoBarView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2275088131, green: 0.2261628211, blue: 0.2285476327, alpha: 0.7836312072)
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var heightTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.textColor = #colorLiteral(red: 0.7416954637, green: 0.7451297045, blue: 0.7535179257, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Light", size: 16)
        return label
    }()
    
    private lazy var heightInfoLabel: UILabel = {
        let label = UILabel()
       return label
    }()
    
    
    //MARK: -- Methods
    public func setViewElementsFromSpeciesData(species: Species) {
        summaryTextView.text = species.populationSummary
    }
    
    private func setAppearance() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.addBlurToView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAppearance()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: -- Adding Subviews & Constraints
extension SpeciesOverviewView {
    
    private func addSubviews() {
        let UIElements =  [overviewTitleLabel, infoBarView, summaryTextView]
        UIElements.forEach{ self.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let infoBarElements = [heightTitleLabel, heightInfoLabel]
        infoBarElements.forEach { infoBarView.addSubview($0) }
        infoBarElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setOverviewTitleLabelConstraints()
        setInfoBarConstraints()
        setHeightTitleLabelConstraints()
        setSummaryTextViewConstraints()
    }
    
    private func setOverviewTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            overviewTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            overviewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            overviewTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            overviewTitleLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setInfoBarConstraints() {
        NSLayoutConstraint.activate([
            infoBarView.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 20),
            infoBarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            infoBarView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            infoBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setHeightTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            heightTitleLabel.topAnchor.constraint(equalTo: infoBarView.topAnchor, constant: 10),
            heightTitleLabel.leadingAnchor.constraint(equalTo: infoBarView.leadingAnchor, constant: 10),
            heightTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            heightTitleLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setSummaryTextViewConstraints() {
        NSLayoutConstraint.activate([
            summaryTextView.topAnchor.constraint(equalTo: infoBarView.bottomAnchor, constant: 20),
            summaryTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            summaryTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            summaryTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
}


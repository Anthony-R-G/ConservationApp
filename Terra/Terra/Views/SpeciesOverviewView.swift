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
        view.backgroundColor = #colorLiteral(red: 0.517944634, green: 0.5203455091, blue: 0.5262002945, alpha: 0.5)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var heightTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.textColor = #colorLiteral(red: 0.8390320539, green: 0.8525128961, blue: 0.8612788916, alpha: 0.7811162243)
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Light", size: 15)
        return label
    }()
    
    private lazy var heightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        return label
    }()
    
    private lazy var weightTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.textColor = #colorLiteral(red: 0.8390320539, green: 0.8525128961, blue: 0.8612788916, alpha: 0.7811162243)
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Light", size: 15)
        return label
    }()
    
    private lazy var weightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        return label
    }()
    
    private lazy var dietTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Diet"
        label.textColor = #colorLiteral(red: 0.8390320539, green: 0.8525128961, blue: 0.8612788916, alpha: 0.7811162243)
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Light", size: 15)
        return label
    }()
    
    private lazy var dietInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        return label
    }()
    
    private lazy var readMoreButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 20)
        btn.setTitle("Read More", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0.1362192035, blue: 0.1518113911, alpha: 1), for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.maskedCorners = [.layerMinXMinYCorner]
        btn.backgroundColor = #colorLiteral(red: 0.9310950637, green: 0.5894679427, blue: 0.5347439647, alpha: 1)
        return btn
    }()
    
    //MARK: -- Methods
    public func setViewElementsFromSpeciesData(species: Species) {
        summaryTextView.text = species.populationSummary
        heightInfoLabel.text = species.height
        weightInfoLabel.text = species.weight
        dietInfoLabel.text = species.diet.rawValue
    }
    
    private func setAppearance() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 39
        self.clipsToBounds = true
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
        let UIElements =  [overviewTitleLabel, infoBarView, summaryTextView, readMoreButton]
        UIElements.forEach{ self.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let infoBarElements = [heightTitleLabel, heightInfoLabel, weightTitleLabel, weightInfoLabel, dietTitleLabel, dietInfoLabel]
        infoBarElements.forEach { infoBarView.addSubview($0) }
        infoBarElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setOverviewTitleLabelConstraints()
        setInfoBarConstraints()
        setHeightTitleLabelConstraints()
        setHeightInfoLabelConstraints()
        setWeightTitleLabelConstraints()
        setWeightInfoLabelConstraints()
        setDietTitleLabelConstraints()
        setDietInfoLabelConstraints()
        setSummaryTextViewConstraints()
        setReadMoreButtonConstraints()
    }
    
    private func setOverviewTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            overviewTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            overviewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            overviewTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            overviewTitleLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setInfoBarConstraints() {
        NSLayoutConstraint.activate([
            infoBarView.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 15),
            infoBarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            infoBarView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.18),
            infoBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setHeightTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            heightTitleLabel.topAnchor.constraint(equalTo: infoBarView.topAnchor, constant: 10),
            heightTitleLabel.centerXAnchor.constraint(equalTo: heightInfoLabel.centerXAnchor),
            heightTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            heightTitleLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setHeightInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            heightInfoLabel.topAnchor.constraint(equalTo: heightTitleLabel.bottomAnchor, constant: 5),
            heightInfoLabel.leadingAnchor.constraint(equalTo: infoBarView.leadingAnchor, constant: 10),
            heightInfoLabel.heightAnchor.constraint(equalToConstant: 30),
            heightInfoLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setWeightTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            weightTitleLabel.topAnchor.constraint(equalTo: heightTitleLabel.topAnchor),
            weightTitleLabel.centerXAnchor.constraint(equalTo: weightInfoLabel.centerXAnchor),
            weightTitleLabel.heightAnchor.constraint(equalTo: heightTitleLabel.heightAnchor),
            weightTitleLabel.widthAnchor.constraint(equalTo: heightTitleLabel.widthAnchor)
        ])
    }
    
    private func setWeightInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            weightInfoLabel.topAnchor.constraint(equalTo: heightInfoLabel.topAnchor),
            weightInfoLabel.leadingAnchor.constraint(equalTo: heightInfoLabel.trailingAnchor, constant: 20),
            weightInfoLabel.heightAnchor.constraint(equalTo: heightInfoLabel.heightAnchor),
            weightInfoLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setDietTitleLabelConstraints() {
           NSLayoutConstraint.activate([
               dietTitleLabel.topAnchor.constraint(equalTo: heightTitleLabel.topAnchor),
               dietTitleLabel.centerXAnchor.constraint(equalTo: dietInfoLabel.centerXAnchor),
               dietTitleLabel.heightAnchor.constraint(equalTo: heightTitleLabel.heightAnchor),
               dietTitleLabel.widthAnchor.constraint(equalTo: heightTitleLabel.widthAnchor)
           ])
       }
       
       private func setDietInfoLabelConstraints() {
           NSLayoutConstraint.activate([
               dietInfoLabel.topAnchor.constraint(equalTo: heightInfoLabel.topAnchor),
               dietInfoLabel.leadingAnchor.constraint(equalTo: weightInfoLabel.trailingAnchor, constant: 10),
               dietInfoLabel.heightAnchor.constraint(equalTo: heightInfoLabel.heightAnchor),
               dietInfoLabel.widthAnchor.constraint(equalToConstant: 100)
           ])
       }
    
    private func setSummaryTextViewConstraints() {
        NSLayoutConstraint.activate([
            summaryTextView.topAnchor.constraint(equalTo: infoBarView.bottomAnchor, constant: 15),
            summaryTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            summaryTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            summaryTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setReadMoreButtonConstraints() {
        NSLayoutConstraint.activate([
            readMoreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            readMoreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            readMoreButton.heightAnchor.constraint(equalToConstant: 60),
            readMoreButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}


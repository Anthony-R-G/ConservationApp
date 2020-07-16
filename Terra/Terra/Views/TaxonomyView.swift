//
//  TaxonomyView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/15/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class TaxonomyView: UIView {
    
    lazy var taxonomyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taxonomy"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var kingdomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kingdomLabel, kingdomInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var kingdomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.text = "Kingdom"
        label.textColor = #colorLiteral(red: 0.6117030382, green: 0.6117962003, blue: 0.6116904616, alpha: 1)
        return label
    }()
    
    lazy var kingdomInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        return label
    }()
    
    lazy var classStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [classLabel, classInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var classLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.text = "Class"
        label.textColor = #colorLiteral(red: 0.6117030382, green: 0.6117962003, blue: 0.6116904616, alpha: 1)
        return label
    }()
    
    lazy var classInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        return label
    }()
    
    lazy var familyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [familyLabel, familyInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var familyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.text = "Family"
        label.textColor = #colorLiteral(red: 0.6117030382, green: 0.6117962003, blue: 0.6116904616, alpha: 1)
        return label
    }()
    
    lazy var familyInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        return label
    }()
    
    lazy var phylumStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phylumLabel, phylumInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var phylumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.text = "Phylum"
        label.textColor = #colorLiteral(red: 0.6117030382, green: 0.6117962003, blue: 0.6116904616, alpha: 1)
        return label
    }()
    
    lazy var phylumInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        return label
    }()
    
    lazy var orderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [orderLabel, orderInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.text = "Order"
        label.textColor = #colorLiteral(red: 0.6117030382, green: 0.6117962003, blue: 0.6116904616, alpha: 1)
        return label
    }()
    
    lazy var orderInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        return label
    }()
    
    lazy var genusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genusLabel, genusInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var genusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.text = "Genus"
        label.textColor = #colorLiteral(red: 0.6117030382, green: 0.6117962003, blue: 0.6116904616, alpha: 1)
        return label
    }()
    
    lazy var genusInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
        return label
    }()
    
    
    public func setUIFromSpecies(species: Species) {
        kingdomInfoLabel.text = species.kingdom
        classInfoLabel.text = species.classTaxonomy
        familyInfoLabel.text = species.family
        phylumInfoLabel.text = species.phylum
        orderInfoLabel.text = species.order
        genusInfoLabel.text = species.genus
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setConstraints()
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaxonomyView {
    
    private func setConstraints() {
        let UIElements =  [taxonomyTitleLabel, kingdomStackView, classStackView, familyStackView, phylumStackView, orderStackView, genusStackView]
        
        UIElements.forEach{ self.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        setTaxonomyTitleLabelConstraints()
        setKingdomStackViewConstraints()
        setClassStackViewConstraints()
        setFamilyStackViewConstraints()
        setPhylumStackViewConstraints()
        setOrderStackViewConstraints()
        setGenusStackViewConstraints()
    }
    
    
    private func setTaxonomyTitleLabelConstraints(){
        NSLayoutConstraint.activate([
            taxonomyTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            taxonomyTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            taxonomyTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            taxonomyTitleLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func setKingdomStackViewConstraints(){
        NSLayoutConstraint.activate([
            kingdomStackView.leadingAnchor.constraint(equalTo: taxonomyTitleLabel.leadingAnchor),
            kingdomStackView.topAnchor.constraint(equalTo: taxonomyTitleLabel.bottomAnchor, constant: 30),
            kingdomStackView.heightAnchor.constraint(equalToConstant: 50),
            kingdomStackView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    private func setClassStackViewConstraints(){
        NSLayoutConstraint.activate([
            classStackView.leadingAnchor.constraint(equalTo: kingdomStackView.leadingAnchor),
            classStackView.topAnchor.constraint(equalTo: kingdomStackView.bottomAnchor, constant: 20),
            classStackView.heightAnchor.constraint(equalTo: kingdomStackView.heightAnchor),
            classStackView.widthAnchor.constraint(equalTo: kingdomStackView.widthAnchor)
        ])
    }
    
    
    private func setFamilyStackViewConstraints(){
        NSLayoutConstraint.activate([
            familyStackView.leadingAnchor.constraint(equalTo: kingdomStackView.leadingAnchor),
            familyStackView.topAnchor.constraint(equalTo: classStackView.bottomAnchor, constant: 20),
            familyStackView.heightAnchor.constraint(equalTo: kingdomStackView.heightAnchor),
            familyStackView.widthAnchor.constraint(equalTo: kingdomStackView.widthAnchor)
        ])
    }
    
    
    private func setPhylumStackViewConstraints(){
        NSLayoutConstraint.activate([
            phylumStackView.leadingAnchor.constraint(equalTo: kingdomStackView.trailingAnchor, constant: 50),
            phylumStackView.topAnchor.constraint(equalTo: kingdomStackView.topAnchor),
            phylumStackView.heightAnchor.constraint(equalTo: kingdomStackView.heightAnchor),
            phylumStackView.widthAnchor.constraint(equalTo: kingdomStackView.widthAnchor)
        ])
    }
    
    
    private func setOrderStackViewConstraints(){
        NSLayoutConstraint.activate([
            orderStackView.leadingAnchor.constraint(equalTo: phylumStackView.leadingAnchor),
            orderStackView.topAnchor.constraint(equalTo: classStackView.topAnchor),
            orderStackView.heightAnchor.constraint(equalTo: kingdomStackView.heightAnchor),
            orderStackView.widthAnchor.constraint(equalTo: kingdomStackView.widthAnchor)
        ])
    }
    
    
    private func setGenusStackViewConstraints(){
        NSLayoutConstraint.activate([
            genusStackView.leadingAnchor.constraint(equalTo: phylumStackView.leadingAnchor),
            genusStackView.topAnchor.constraint(equalTo: familyStackView.topAnchor),
            genusStackView.heightAnchor.constraint(equalTo: kingdomStackView.heightAnchor),
            genusStackView.widthAnchor.constraint(equalTo: kingdomStackView.widthAnchor)
        ])
    }
}


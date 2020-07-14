//
//  DetailInfoOverlay.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class DetailInfoOverlay: UIView {
    
    lazy var summaryTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.textColor = #colorLiteral(red: 0.3074202836, green: 0.3078328371, blue: 0.416093111, alpha: 1)
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.backgroundColor = .clear
        tv.textAlignment = .left
        return tv
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Kingdom"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var kingdomInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Class"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var classInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Family"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var familyInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Phylum"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var phylumInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Order"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var orderInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Genus"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var genusInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    
    lazy var summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    lazy var taxonomyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taxonomy"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    func setUIFromSpecies(species: Species) {
        summaryTextView.text = species.habitat
        kingdomInfoLabel.text = species.kingdom
        classInfoLabel.text = species.classTaxonomy
        familyInfoLabel.text = species.family
        phylumInfoLabel.text = species.phylum
        orderInfoLabel.text = species.order
        genusInfoLabel.text = species.genus
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9025845462)
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Constraints
extension DetailInfoOverlay {
    
    private func setSummaryTitleLabelConstraints(){
           NSLayoutConstraint.activate([
               summaryTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
               summaryTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
               summaryTitleLabel.heightAnchor.constraint(equalToConstant: 30),
               summaryTitleLabel.widthAnchor.constraint(equalToConstant: 130)
           ])
       }
    
    private func setSummaryTextViewConstraints(){
        NSLayoutConstraint.activate([
            summaryTextView.topAnchor.constraint(equalTo: summaryTitleLabel.bottomAnchor, constant: 10),
            summaryTextView.leadingAnchor.constraint(equalTo: summaryTitleLabel.leadingAnchor),
            summaryTextView.widthAnchor.constraint(equalToConstant: 300),
            summaryTextView.bottomAnchor.constraint(equalTo: taxonomyTitleLabel.topAnchor, constant: -20)
        ])
    }
    
   
    
    
    private func setTaxonomyTitleLabelConstraints(){
        NSLayoutConstraint.activate([
            taxonomyTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            taxonomyTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            taxonomyTitleLabel.heightAnchor.constraint(equalTo: summaryTitleLabel.heightAnchor),
            taxonomyTitleLabel.widthAnchor.constraint(equalTo: summaryTitleLabel.widthAnchor)
        ])
    }
    
    
    private func setKingdomStackViewConstraints(){
        NSLayoutConstraint.activate([
            kingdomStackView.leadingAnchor.constraint(equalTo: summaryTitleLabel.leadingAnchor),
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
    
    
    private func setConstraints() {
        let UIElements =  [summaryTitleLabel, taxonomyTitleLabel, kingdomStackView, classStackView, familyStackView, phylumStackView, orderStackView, genusStackView, summaryTextView]
        
        UIElements.forEach{ self.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        setSummaryTitleLabelConstraints()
        setSummaryTextViewConstraints()
        setTaxonomyTitleLabelConstraints()
        setKingdomStackViewConstraints()
        setClassStackViewConstraints()
        setFamilyStackViewConstraints()
        setPhylumStackViewConstraints()
        setOrderStackViewConstraints()
        setGenusStackViewConstraints()
    }
}

//
//  TaxonomyView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class TaxonomyView: UIView {
    private lazy var kingdomTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Kingdom",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var kingdomDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var classTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Class",
                                        weight: .regular,
                                        size: 15,
                                        color: .lightGray,
                                        alignment: .left)
    }()
    
    private lazy var classDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                        weight: .bold,
                                        size: 18,
                                        color: .white,
                                        alignment: .left)
    }()
    
    private lazy var familyTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Family",
                                        weight: .regular,
                                        size: 15,
                                        color: .lightGray,
                                        alignment: .left)
    }()
    
    
    private lazy var familyDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                        weight: .bold,
                                        size: 18,
                                        color: .white,
                                        alignment: .left)
    }()
    
    private lazy var phylumTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Phylum",
                                        weight: .regular,
                                        size: 15,
                                        color: .lightGray,
                                        alignment: .left)
    }()
    
    private lazy var phylumDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                        weight: .bold,
                                        size: 18,
                                        color: .white,
                                        alignment: .left)
    }()
    
    private lazy var orderTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Order",
                                        weight: .regular,
                                        size: 15,
                                        color: .lightGray,
                                        alignment: .left)
    }()
    
    private lazy var orderDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                        weight: .bold,
                                        size: 18,
                                        color: .white,
                                        alignment: .left)
    }()
    
    private lazy var genusTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Genus",
                                        weight: .regular,
                                        size: 15,
                                        color: .lightGray,
                                        alignment: .left)
    }()
    
    private lazy var genusDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                        weight: .bold,
                                        size: 18,
                                        color: .white,
                                        alignment: .left)
    }()
    
    private lazy var leftStack: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [
       kingdomTitleLabel, kingdomDataLabel,
       classTitleLabel, classDataLabel,
       familyTitleLabel, familyDataLabel
       ])
        sv.axis = .vertical
        sv.spacing = 10
        sv.setCustomSpacing(20, after: kingdomDataLabel)
        sv.setCustomSpacing(20, after: classDataLabel)
        return sv
    }()
    
    private lazy var rightStack: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [
       phylumTitleLabel, phylumDataLabel,
       orderTitleLabel, orderDataLabel,
       genusTitleLabel, genusDataLabel
       ])
        sv.axis = .vertical
        sv.spacing = 10
        sv.setCustomSpacing(20, after: phylumDataLabel)
        sv.setCustomSpacing(20, after: orderDataLabel)
        return sv
    }()
    
    func configureTaxonomyData(from species: Species) {
        kingdomDataLabel.text = species.taxonomy.kingdom
        phylumDataLabel.text = species.taxonomy.phylum
        classDataLabel.text = species.taxonomy.classTaxonomy
        orderDataLabel.text = species.taxonomy.order
        familyDataLabel.text = species.taxonomy.family
        genusDataLabel.text = species.taxonomy.genus
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension TaxonomyView {
    func addSubviews() {
       let UIElements = [leftStack, rightStack]
        UIElements.forEach { addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setLeftStackConstraints()
        setRightStackConstraints()
    }
    
    func setLeftStackConstraints() {
        leftStack.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            
        }
    }
    
    func setRightStackConstraints() {
        rightStack.snp.makeConstraints { (make) in
            make.trailing.top.bottom.equalToSuperview()
        }
    }
}

//
//  OverviewDistributionView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class OverviewDistributionView: UIView {
    
    lazy var titleLabel: UILabel = {
           let label = Factory.makeLabel(title: "TITLE",
                                         weight: .bold,
                                         size: 24,
                                         color: Constants.titleLabelColor,
                                         alignment: .left)
           return label
       }()
    
    lazy var taxonomyView: TaxonomyView = {
        return TaxonomyView()
    }()
    
    private func setContentViewBottomConstraint() {
        if let lastSubview = subviews.last {
            bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 20).isActive = true
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2452108305)
        layer.cornerRadius = 20
        addSubviews()
        setConstraints()
        setContentViewBottomConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -- Add Subviews & Constraints

fileprivate extension OverviewDistributionView {
    func addSubviews() {
        let UIElements = [titleLabel, taxonomyView]
        UIElements.forEach { addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setTitleLabelConstraints()
        setLabelConstraints()
        
    }
    
    func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setLabelConstraints() {
        NSLayoutConstraint.activate([
            taxonomyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            taxonomyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            taxonomyView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            taxonomyView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}


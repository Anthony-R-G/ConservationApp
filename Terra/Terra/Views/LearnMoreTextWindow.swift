//
//  OverviewSummaryView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class LearnMoreTextWindow: UIView {
    //MARK: UI Element Initialization
    
    private lazy var titleLabel: UILabel = {
        let label = Factory.makeLabel(title: strategy.titleLabel(),
                                      weight: .bold,
                                      size: 24,
                                      color: Constants.titleLabelColor,
                                      alignment: .left)
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = Factory.makeLabel(title: strategy.bodyText(),
                                      weight: .regular,
                                      size: 16,
                                      color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8983304795),
                                      alignment: .natural)
        
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: -- Properties
    
    var strategy: LearnMoreTextWindowStrategy!
    
    
    //MARK: -- Methods
    
    private func setBottomAnchor() {
        if let lastSubview = subviews.last {
            bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 20).isActive = true
        }
    }
    private func configureAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2452108305)
        layer.cornerRadius = 20
    }
    
    init(strategy: LearnMoreTextWindowStrategy) {
        super.init(frame: .zero)
        self.strategy = strategy
        configureAppearance()
        addSubviews()
        setConstraints()
        setBottomAnchor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension LearnMoreTextWindow {
    func addSubviews() {
        let UIElements = [titleLabel, bodyLabel]
        UIElements.forEach { addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setTitleLabelConstraints()
        setBodyLabelConstraints()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
        }
    }
    
    func setBodyLabelConstraints() {
        bodyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

//
//  OverviewDistributionView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class LearnMoreContentViewWindow: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var titleLabel: UILabel = {
        let label = Factory.makeLabel(title: strategy.titleLabel(),
                                      weight: .bold,
                                      size: 24,
                                      color: Constants.titleLabelColor,
                                      alignment: .left)
        return label
    }()
    
    
    private lazy var contentView: UIView = {
        return strategy.contentView()
    }()
    
    //MARK: -- Properties
    var strategy: LearnMoreContentWindowStrategy!
    
    
    private func setBottomConstraint() {
        if let lastSubview = subviews.last {
            bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 20).isActive = true
        }
    }
    
    //MARK: -- Methods
    private func configureAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2452108305)
        layer.cornerRadius = 20
    }
    
    
    init(strategy: LearnMoreContentWindowStrategy) {
        super.init(frame: .zero)
        self.strategy = strategy
        configureAppearance()
        addSubviews()
        setTitleLabelConstraints()
        setContentViewConstraints()
        setBottomConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -- Add Subviews & Constraints

fileprivate extension LearnMoreContentViewWindow {
    func addSubviews() {
        let UIElements = [titleLabel, contentView]
        UIElements.forEach { addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    
    func setTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
        }
    }
    
    func setContentViewConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}


//
//  OverviewDistributionView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class LearnMoreContentViewWindow: UIView {
    
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
    
    var strategy: LearnMoreContentWindowStrategy!
    
    private func setBottomConstraint() {
        if let lastSubview = subviews.last {
            bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 20).isActive = true
        }
    }
    
    
    init(height: CGFloat, strategy: LearnMoreContentWindowStrategy) {
        super.init(frame: .zero)
        self.strategy = strategy
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2452108305)
        layer.cornerRadius = 20
        addSubviews()
        setTitleLabelConstraints()
        setContentViewConstraints(height: height)
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
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setContentViewConstraints(height: CGFloat) {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}


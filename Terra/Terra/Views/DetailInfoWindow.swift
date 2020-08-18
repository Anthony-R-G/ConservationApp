//
//  OverviewDistributionView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class DetailInfoWindow: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var titleLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      weight: .bold,
                                      size: 24,
                                      color: Constants.titleLabelColor,
                                      alignment: .left)
        return label
    }()
    
    
    private var contentView = UIView()
    
    //MARK: -- Methods
    
    private func setBottomConstraint() {
        if let lastSubview = subviews.last {
            bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: Constants.spacingConstant).isActive = true
        }
    }
    
    private func configureAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2452108305)
        layer.cornerRadius = Constants.cornerRadius
    }
    
    
    init(title: String, content: UIView) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.contentView = content
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

fileprivate extension DetailInfoWindow {
    func addSubviews() {
        let UIElements = [titleLabel, contentView]
        UIElements.forEach { addSubview($0) }
    }
    
    
    func setTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(Constants.spacingConstant)
            make.top.equalToSuperview().inset(Constants.spacingConstant)
        }
    }
    
    func setContentViewConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacingConstant/2)
            make.leading.trailing.equalToSuperview().inset(Constants.spacingConstant)
        }
    }
}


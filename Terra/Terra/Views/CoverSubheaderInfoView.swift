//
//  SubheaderInfoView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/18/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class CoverSubheaderInfoView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var numbersTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Numbers",
                                 weight: .light,
                                 size: 16,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var numbersDataLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .medium,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var trendTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Trend",
                                 weight: .light,
                                 size: 16,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var trendDataLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .medium,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var lastAssessedTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Last Assessed",
                                 weight: .light,
                                 size: 16,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var lastAssessedDataLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .medium,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var numbersStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            numbersTitleLabel, numbersDataLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var trendStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            trendTitleLabel, trendDataLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var lastAssessedStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            lastAssessedTitleLabel, lastAssessedDataLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        numbersStack, trendStack, lastAssessedStack
        ])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: -- Methods
    func configureView(from species: Species) {
        numbersDataLabel.text = species.population.numbers
        trendDataLabel.text = species.population.trend.rawValue
        trendDataLabel.textColor = species.population.trend == .decreasing ? #colorLiteral(red: 1, green: 0.4507741928, blue: 0.5112823844, alpha: 1) : #colorLiteral(red: 0.7970843911, green: 1, blue: 0.5273691416, alpha: 1)
        lastAssessedDataLabel.text = "\(species.population.assessmentDate)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(horizontalStack)
        setHorizontalStackConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension CoverSubheaderInfoView {
    
    func setHorizontalStackConstraints() {
        horizontalStack.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
    }
}

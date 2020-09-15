//
//  SubheaderInfoView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/18/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class CoverSpeciesStatsView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var populationTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Population",
                                 fontWeight: .light,
                                 fontSize: 15,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var populationDataLabel: UILabel = {
        return Factory.makeLabel(title: viewModel.speciesPopulationNumbers,
                                 fontWeight: .regular,
                                 fontSize: 18,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var trendTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Trend",
                                 fontWeight: .light,
                                 fontSize: 15,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var trendDataLabel: UILabel = {
        return Factory.makeLabel(title: viewModel.speciesPopulationTrend.rawValue,
                                 fontWeight: .regular,
                                 fontSize: 18,
                                 widthAdjustsFontSize: true,
                                 color: viewModel.speciesPopulationTrend == .decreasing ? #colorLiteral(red: 1, green: 0.4507741928, blue: 0.5112823844, alpha: 1) : #colorLiteral(red: 0.7970843911, green: 1, blue: 0.5273691416, alpha: 1),
                                 alignment: .left)
    }()
    
    private lazy var lastAssessedTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Last Assessed",
                                 fontWeight: .light,
                                 fontSize: 15,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var lastAssessedDataLabel: UILabel = {
        return Factory.makeLabel(title: "\(viewModel.speciesLastAssessedDate)",
                                 fontWeight: .regular,
                                 fontSize: 18,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var numbersStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            populationTitleLabel, populationDataLabel
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
        return stackView
    }()
    
    //MARK: -- Properties
    
    private var viewModel: SpeciesDetailViewModel!
    
    //MARK: -- Methods
    required init(viewModel: SpeciesDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        addSubview(horizontalStack)
        setHorizontalStackConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension CoverSpeciesStatsView {
    
    func setHorizontalStackConstraints() {
        horizontalStack.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
    }
}

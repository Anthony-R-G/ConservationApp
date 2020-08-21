//
//  HabitatSummaryView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/21/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class BiomeView: UIView {
    //MARK: -- UI Element Initialization
    private lazy var biomeImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: species.habitat.biome.rawValue)
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        return iv
    }()
    private lazy var biomeTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Biome",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .center)
    }()
    
    private lazy var biomeDataLabel: UILabel = {
        return Factory.makeLabel(title: species.habitat.biome.rawValue,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .center)
    }()
    
    private lazy var areaTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Area",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .center)
    }()
    
    private lazy var areaDataLabel: UILabel = {
        return Factory.makeLabel(title: species.habitat.area,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .center)
    }()
    
    private lazy var temperatureTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Temperature",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .center)
    }()
    
    private lazy var temperatureDataLabel: UILabel = {
        return Factory.makeLabel(title: species.habitat.temperature,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .center)
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            biomeTitleLabel, biomeDataLabel,
            areaTitleLabel, areaDataLabel,
            temperatureTitleLabel, temperatureDataLabel
        ])
        sv.axis = .vertical
        sv.spacing = Constants.spacingConstant/2
        sv.setCustomSpacing(Constants.spacingConstant, after: biomeDataLabel)
        sv.setCustomSpacing(Constants.spacingConstant, after: areaDataLabel)
        return sv
    }()
    
    //MARK: -- Properties
    
    private var species: Species
    
    //MARK: -- Methods
    
    private func setBottomConstraint() {
        if let lastSubview = subviews.last {
            bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: Constants.spacingConstant).isActive = true
        }
    }
    
    required init(species: Species) {
        self.species = species
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
        setBottomConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension BiomeView {
    
    func addSubviews() {
        addSubview(biomeImage)
        addSubview(stackView)
    }
    
    func setConstraints() {
        setBiomeImageConstraints()
        setStackConstraints()
    }
    
    func setBiomeImageConstraints() {
        biomeImage.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    func setStackConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(biomeImage.snp.bottom).offset(20)
        }
    }
}

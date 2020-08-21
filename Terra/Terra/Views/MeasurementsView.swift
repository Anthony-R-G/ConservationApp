//
//  MeasurementsView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/21/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class MeasurementsView: UIView {
    
    //MARK: -- UI Element Initialization
    
    private lazy var heightTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Height",
                                 weight: .bold,
                                 size: 19,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var maleHeightDataLabel: UILabel = {
        return Factory.makeLabel(title: "Male: \(species.measurements.averageMaleHeight)",
            weight: .regular,
            size: 17,
            color: .white,
            alignment: .left)
    }()
    
    private lazy var femaleHeightDataLabel: UILabel = {
        return Factory.makeLabel(title: "Female: \(species.measurements.averageFemaleHeight)",
            weight: .regular,
            size: 17,
            color: .white,
            alignment: .left)
    }()
    
    private lazy var heightReferenceTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Adult, At Shoulder",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var heightStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            heightTitleLabel, maleHeightDataLabel, femaleHeightDataLabel, heightReferenceTitleLabel
        ])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 20
        return sv
    }()
    
    private lazy var weightTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Weight",
                                 weight: .bold,
                                 size: 19,
                                 color: .white,
                                 alignment: .right)
    }()
    
    private lazy var maleWeightDataLabel: UILabel = {
        return Factory.makeLabel(title: species.measurements.averageMaleWeight,
            weight: .regular,
            size: 17,
            color: .white,
            alignment: .right)
    }()
    
    private lazy var femaleWeightDataLabel: UILabel = {
        return Factory.makeLabel(title: species.measurements.averageFemaleWeight,
            weight: .regular,
            size: 17,
            color: .white,
            alignment: .right)
    }()
    
    private lazy var weightStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            weightTitleLabel, maleWeightDataLabel, femaleWeightDataLabel, UILabel()
        ])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 20
        return sv
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            heightStackView, weightStackView
        ])
        sv.spacing = Constants.spacingConstant/2
        sv.alignment = .leading
        return sv
    }()
    
    //MARK: -- Properties
    
    private var species: Species!
    
    required init(species: Species) {
        self.species = species
        super.init(frame: .zero)
        self.heightAnchor.constraint(equalToConstant: 150).isActive = true
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

extension MeasurementsView {
    func addSubviews() {
        addSubview(horizontalStack)
    }
    
    func setConstraints() {
        setHeightStackConstraints()
    }
    
    func setHeightStackConstraints() {
        horizontalStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

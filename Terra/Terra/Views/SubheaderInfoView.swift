//
//  HeaderStacksView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/18/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class SubheaderInfoView: UIView {
    
    //    private lazy var numbersStackView: UIStackView = {
    //        let stackView = UIStackView(arrangedSubviews: [numbersLabel, numbersInfoLabel])
    //        stackView.alignment = .fill
    //        stackView.distribution = .fillEqually
    //        stackView.spacing = 2
    //        stackView.axis = .vertical
    //        return stackView
    //    }()
    
    private lazy var numbersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Numbers"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Light", size: 16)
        label.backgroundColor = .blue
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var numbersInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
        
    }()
    
    private lazy var weightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weightLabel, weightInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Weight"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        return label
    }()
    
    private lazy var weightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        return label
    }()
    
    private lazy var heightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heightLabel, heightInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Height"
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        return label
    }()
    
    private lazy var heightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        return label
    }()
    
    public func setViewElementsFromSpeciesData(species: Species) {
        numbersInfoLabel.text = species.populationNumbers
        weightInfoLabel.text = species.weight
        heightInfoLabel.text = species.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SubheaderInfoView {
    
    private func addSubviews() {
        //        let UIElements = [numbersStackView, weightStackView, heightStackView]
        //        UIElements.forEach { self.addSubview($0) }
        //        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        let UIElements = [numbersLabel, numbersInfoLabel]
        UIElements.forEach { self.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    private func setConstraints() {
        setNumbersInfoLabelConstraints()
        setNumbersLabelConstraints()
        //        setNumbersStackConstraints()
        //        setWeightStackConstraints()
        //        setHeightStackConstraints()
    }
    
    private func setNumbersLabelConstraints() {
        NSLayoutConstraint.activate([
            numbersLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numbersLabel.topAnchor.constraint(equalTo: self.topAnchor),
            numbersLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            numbersLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ])
    }
    
    private func setNumbersInfoLabelConstraints() {
        NSLayoutConstraint.activate([
            numbersInfoLabel.leadingAnchor.constraint(equalTo: numbersLabel.leadingAnchor),
            numbersInfoLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            numbersInfoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            numbersInfoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
    
    
//    private func setNumbersStackConstraints() {
//        NSLayoutConstraint.activate([
//            numbersStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
//            numbersStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            numbersStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3 ),
//            numbersStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
//        ])
//    }
    //
    //    private func setWeightStackConstraints() {
    //        NSLayoutConstraint.activate([
    //            weightStackView.topAnchor.constraint(equalTo: numbersStackView.topAnchor),
    //            weightStackView.leadingAnchor.constraint(equalTo: numbersStackView.trailingAnchor, constant: 25),
    //            weightStackView.heightAnchor.constraint(equalTo: numbersStackView.heightAnchor),
    //            weightStackView.widthAnchor.constraint(equalTo: numbersStackView.widthAnchor)
    //        ])
    //    }
    //
    //    private func setHeightStackConstraints() {
    //        NSLayoutConstraint.activate([
    //            heightStackView.topAnchor.constraint(equalTo: numbersStackView.topAnchor),
    //            heightStackView.leadingAnchor.constraint(equalTo: weightStackView.trailingAnchor, constant: 25),
    //            heightStackView.heightAnchor.constraint(equalTo: numbersStackView.heightAnchor),
    //            heightStackView.widthAnchor.constraint(equalTo: numbersStackView.widthAnchor)
    //        ])
    //    }
}

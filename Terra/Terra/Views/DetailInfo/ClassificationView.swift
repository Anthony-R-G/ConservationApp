//
//  TaxonomyView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import AVFoundation

final class ClassificationView: UIView {
    //MARK: -- UI Element Initialization
    private lazy var kingdomTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Kingdom",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var kingdomDataLabel: UILabel = {
        return Factory.makeLabel(title: species.taxonomy.kingdom,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var phylumTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Phylum",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var phylumDataLabel: UILabel = {
        return Factory.makeLabel(title: species.taxonomy.phylum,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var classTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Class",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var classDataLabel: UILabel = {
        return Factory.makeLabel(title: species.taxonomy.classTaxonomy,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var orderTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Order",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var orderDataLabel: UILabel = {
        return Factory.makeLabel(title: species.taxonomy.order,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var familyTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Family",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var familyDataLabel: UILabel = {
        return Factory.makeLabel(title: species.taxonomy.family,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var genusTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Genus",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var genusDataLabel: UILabel = {
        return Factory.makeLabel(title: species.taxonomy.genus,
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var scientificNameTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Scientific Name",
                                 weight: .regular,
                                 size: 16,
                                 color: .lightGray,
                                 alignment: .center)
    }()
    
    private lazy var scientificNameDataLabel: UILabel = {
        return Factory.makeLabel(title: species.taxonomy.scientificName,
                                 weight: .italic,
                                 size: 18,
                                 color: .white,
                                 alignment: .center)
    }()
    
    private lazy var leftStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            kingdomTitleLabel, kingdomDataLabel,
            classTitleLabel, classDataLabel,
            familyTitleLabel, familyDataLabel
        ])
        sv.axis = .vertical
        sv.spacing = Constants.spacingConstant/2
        sv.setCustomSpacing(Constants.spacingConstant, after: kingdomDataLabel)
        sv.setCustomSpacing(Constants.spacingConstant, after: classDataLabel)
        return sv
    }()
    
    private lazy var rightStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            phylumTitleLabel, phylumDataLabel,
            orderTitleLabel, orderDataLabel,
            genusTitleLabel, genusDataLabel
        ])
        sv.axis = .vertical
        sv.spacing = Constants.spacingConstant/2
        sv.setCustomSpacing(Constants.spacingConstant, after: phylumDataLabel)
        sv.setCustomSpacing(Constants.spacingConstant, after: orderDataLabel)
        return sv
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            leftStack, rightStack
        ])
        sv.spacing = Constants.spacingConstant/2
        sv.alignment = .center
        return sv
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var audioButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "speaker.3"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(audioButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    
    //MARK: -- Methods
    
    private var species: Species!
    
    @objc private func audioButtonPressed() {
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: species.taxonomy.scientificName)
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        audioButton.isUserInteractionEnabled = false
        audioButton.tintColor = .darkGray
        speechSynthesizer.speak(speechUtterance)
    }
    
    required init(species: Species) {
        self.species = species
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
        speechSynthesizer.delegate = self
        self.snp.makeConstraints { (make) in
            make.height.equalTo(260)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Speech Synth Delegate

extension ClassificationView: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        audioButton.isUserInteractionEnabled = true
        audioButton.tintColor = .white
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension ClassificationView {
    func addSubviews() {
        let UIElements = [horizontalStack, separatorLine, scientificNameTitleLabel ,scientificNameDataLabel, audioButton]
        UIElements.forEach { addSubview($0) }
    }
    
    func setConstraints() {
        setHorizontalStackConstraints()
        setSeparatorLineConstraints()
        setScientificNameTitleLabelConstraints()
        setScientificNameDataLabelConstraints()
        setAudioButtonConstraints()
    }
    
    func setHorizontalStackConstraints() {
        horizontalStack.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setSeparatorLineConstraints() {
        separatorLine.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(horizontalStack.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
    }
    
    func setScientificNameTitleLabelConstraints() {
        scientificNameTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(separatorLine.snp.bottom).offset(15)
        }
    }
    
    func setScientificNameDataLabelConstraints() {
        scientificNameDataLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(scientificNameTitleLabel.snp.bottom).offset(5)
        }
    }
    
    func setAudioButtonConstraints() {
        audioButton.snp.makeConstraints { (make) in
            make.leading.equalTo(scientificNameDataLabel.snp.trailing).offset(5)
            make.height.width.equalTo(30)
            make.centerY.equalTo(scientificNameDataLabel)
        }
    }
}



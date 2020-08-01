//
//  DetailInfoPanelView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit



struct SpeciesHabitatStrategy: SpeciesStrategy {
    var species: Species
    
    func titleText() -> String {
        return "HABITAT"
    }
    
    func bodyText() -> String {
        return species.habitat.summary
    }
    
    func barLeftTitleText() -> String {
        return "Temperature"
    }
    
    func barMiddleTitleText() -> String {
        return "Humidity"
    }
    
    func barRightTitleText() -> String {
        return "Latitude"
    }
    
    func barLeftDataText() -> String {
        return species.habitat.temperature
    }
    
    func barMiddleDataText() -> String {
        return "" //No data for this yet
    }
    
    func barRightDataText() -> String {
        return "\(species.habitat.latitude)"
    }
}


struct SpeciesGalleryStrategy {
    var species: Species
    
    func titleText() -> String {
        return "GALLERY"
    }
    
    func bodyText() -> String {
        return "o"
    }
}

class RoundedInfoView: UIView {
    
    //MARK: -- UI Element Initialization
    
    private lazy var titleLabel: UILabel = {
        return Utilities.makeLabel(title: "TITLE", weight: .bold, size: 28, color: .white, alignment: .left)
    }()
    
    private lazy var bodyTextLabel: UILabel = {
        let label = Utilities.makeLabel(title: nil, weight: .light, size: 17, color: #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1), alignment: .natural)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    private lazy var infoBarView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.517944634, green: 0.5203455091, blue: 0.5262002945, alpha: 0.5)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var barLeftTitleLabel: UILabel = {
        return Utilities.makeLabel(title: "Title Label A", weight: .light, size: 15, color: #colorLiteral(red: 0.8390320539, green: 0.8525128961, blue: 0.8612788916, alpha: 0.7811162243), alignment: .center)
    }()
    
    private lazy var barLeftDataLabel: UILabel = {
        return Utilities.makeLabel(title: nil, weight: .medium, size: 18, color: .white, alignment: .center)
    }()
    
    private lazy var barMiddleTitleLabel: UILabel = {
        return Utilities.makeLabel(title: "Title Label B", weight: .light, size: 15, color: #colorLiteral(red: 0.8390320539, green: 0.8525128961, blue: 0.8612788916, alpha: 0.7811162243), alignment: .center)
    }()
    
    private lazy var barMiddleDataLabel: UILabel = {
        return Utilities.makeLabel(title: nil, weight: .medium, size: 18, color: .white, alignment: .center)
    }()
    
    private lazy var barRightTitleLabel: UILabel = {
        return Utilities.makeLabel(title: "Title Label C", weight: .light, size: 15, color: #colorLiteral(red: 0.8390320539, green: 0.8525128961, blue: 0.8612788916, alpha: 0.7811162243), alignment: .center)
    }()
    
    private lazy var barRightDataLabel: UILabel = {
        return Utilities.makeLabel(title: nil, weight: .medium, size: 18, color: .white, alignment: .center)
    }()
    
    private lazy var learnMoreButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 20)
        btn.setTitle("Learn More", for: .normal)
        btn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        btn.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btn.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btn.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btn.imageEdgeInsets = UIEdgeInsets(top: 2.5, left: -5, bottom: 0, right: 5)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        btn.tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        btn.showsTouchWhenHighlighted = true
        return btn
    }()
    
    //MARK: -- Methods
    
    var strategy: SpeciesStrategy
    
    public func configureTitleLabels(
        titleText: String,
        barLeftTitle: String,
        barMiddleTitle: String,
        barRightTitle: String) {
        titleLabel.text = titleText.uppercased()
        barLeftTitleLabel.text = barLeftTitle.capitalized
        barMiddleTitleLabel.text = barMiddleTitle.capitalized
        barRightTitleLabel.text = barRightTitle.capitalized
    }
    
    private func configureDataLabels() {
        titleLabel.text = strategy.titleText()
        bodyTextLabel.text = strategy.bodyText()
        
        barLeftTitleLabel.text = strategy.barLeftTitleText()
        barMiddleTitleLabel.text = strategy.barMiddleDataText()
        barRightTitleLabel.text = strategy.barRightTitleText()
        
        
        barLeftDataLabel.text = strategy.barLeftDataText()
        barMiddleDataLabel.text = strategy.barMiddleDataText()
        barRightDataLabel.text = strategy.barRightDataText()
    }
    
    public func addLearnMoreAction(buttonTag: Int, target: Any, selector: Selector) {
        learnMoreButton.tag = buttonTag
        learnMoreButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    private func setAppearance() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 39
        self.clipsToBounds = true
        self.addBlurToView(cornerRadius: 39)
    }
    
    init(frame: CGRect, strategy: SpeciesStrategy) {
        self.strategy = strategy
        super.init(frame: frame)
        setAppearance()
        addSubviews()
        setConstraints()
        configureDataLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension RoundedInfoView {
    
    func addSubviews() {
        let UIElements =  [titleLabel, infoBarView, bodyTextLabel, learnMoreButton]
        UIElements.forEach{ self.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let infoBarElements = [barLeftTitleLabel, barLeftDataLabel, barMiddleTitleLabel, barMiddleDataLabel, barRightTitleLabel, barRightDataLabel]
        infoBarElements.forEach { infoBarView.addSubview($0) }
        infoBarElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setOverviewTitleLabelConstraints()
        setInfoBarConstraints()
        
        setInfoBarTitleLabelAConstraints()
        setInfoBarDataLabelAConstraints()
        
        setInfoBarTitleLabelBConstraints()
        setInfoBarDataLabelBConstraints()
        
        setInfoBarTitleLabelCConstraints()
        setInfoBarDataLabelCConstraints()
        
        setBodyTextViewConstraints()
        setReadMoreButtonConstraints()
    }
    
    func setOverviewTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setInfoBarConstraints() {
        NSLayoutConstraint.activate([
            infoBarView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            infoBarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            infoBarView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.18),
            infoBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    func setInfoBarTitleLabelAConstraints() {
        NSLayoutConstraint.activate([
            barLeftTitleLabel.topAnchor.constraint(equalTo: infoBarView.topAnchor, constant: 10),
            barLeftTitleLabel.centerXAnchor.constraint(equalTo: barLeftDataLabel.centerXAnchor),
            barLeftTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            barLeftTitleLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func setInfoBarDataLabelAConstraints() {
        NSLayoutConstraint.activate([
            barLeftDataLabel.topAnchor.constraint(equalTo: barLeftTitleLabel.bottomAnchor, constant: 5),
            barLeftDataLabel.leadingAnchor.constraint(equalTo: infoBarView.leadingAnchor, constant: 15),
            barLeftDataLabel.heightAnchor.constraint(equalToConstant: 30),
            barLeftDataLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setInfoBarTitleLabelBConstraints() {
        NSLayoutConstraint.activate([
            barMiddleTitleLabel.topAnchor.constraint(equalTo: barLeftTitleLabel.topAnchor),
            barMiddleTitleLabel.centerXAnchor.constraint(equalTo: barMiddleDataLabel.centerXAnchor),
            barMiddleTitleLabel.heightAnchor.constraint(equalTo: barLeftTitleLabel.heightAnchor),
            barMiddleTitleLabel.widthAnchor.constraint(equalTo: barLeftTitleLabel.widthAnchor)
        ])
    }
    
    func setInfoBarDataLabelBConstraints() {
        NSLayoutConstraint.activate([
            barMiddleDataLabel.topAnchor.constraint(equalTo: barLeftDataLabel.topAnchor),
            barMiddleDataLabel.leadingAnchor.constraint(equalTo: barLeftDataLabel.trailingAnchor, constant: 15),
            barMiddleDataLabel.heightAnchor.constraint(equalTo: barLeftDataLabel.heightAnchor),
            barMiddleDataLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setInfoBarTitleLabelCConstraints() {
        NSLayoutConstraint.activate([
            barRightTitleLabel.topAnchor.constraint(equalTo: barLeftTitleLabel.topAnchor),
            barRightTitleLabel.centerXAnchor.constraint(equalTo: barRightDataLabel.centerXAnchor),
            barRightTitleLabel.heightAnchor.constraint(equalTo: barLeftTitleLabel.heightAnchor),
            barRightTitleLabel.widthAnchor.constraint(equalTo: barLeftTitleLabel.widthAnchor)
        ])
    }
    
    func setInfoBarDataLabelCConstraints() {
        NSLayoutConstraint.activate([
            barRightDataLabel.topAnchor.constraint(equalTo: barLeftDataLabel.topAnchor),
            barRightDataLabel.trailingAnchor.constraint(equalTo: infoBarView.trailingAnchor, constant: -15),
            barRightDataLabel.heightAnchor.constraint(equalTo: barLeftDataLabel.heightAnchor),
            barRightDataLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setBodyTextViewConstraints() {
        NSLayoutConstraint.activate([
            bodyTextLabel.topAnchor.constraint(equalTo: infoBarView.bottomAnchor, constant: 15),
            bodyTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bodyTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            bodyTextLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    func setReadMoreButtonConstraints() {
        NSLayoutConstraint.activate([
            learnMoreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            learnMoreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            learnMoreButton.heightAnchor.constraint(equalToConstant: 40),
            learnMoreButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
}

//
//  DetailInfoPanelView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class DetailInfoPanelView: UIView {
    
    //MARK: -- UI Element Initialization
    
    public lazy var titleLabel: UILabel = {
        return Utilities.makeLabel(title: "TITLE", weight: .bold, size: 28, alignment: .left)
    }()
    
    public lazy var bodyTextView: UILabel = {
        let label = Utilities.makeLabel(title: nil, weight: .light, size: 17, alignment: .natural)
        label.textColor = #colorLiteral(red: 1, green: 0.9833787084, blue: 0.8849565387, alpha: 1)
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
    
    private lazy var infoBarTitleLabelA: UILabel = {
        let label = Utilities.makeLabel(title: "Title Label A", weight: .light, size: 15, alignment: .center)
        label.textColor = #colorLiteral(red: 0.8390320539, green: 0.8525128961, blue: 0.8612788916, alpha: 0.7811162243)
        return label
    }()
    
    public lazy var infoBarDataLabelA: UILabel = {
        return Utilities.makeLabel(title: nil, weight: .medium, size: 18, alignment: .center)
    }()
    
    private lazy var infoBarTitleLabelB: UILabel = {
        let label = Utilities.makeLabel(title: "Title Label B", weight: .light, size: 15, alignment: .center)
        label.textColor = #colorLiteral(red: 0.8390320539, green: 0.8525128961, blue: 0.8612788916, alpha: 0.7811162243)
        return label
    }()
    
    public lazy var infoBarDataLabelB: UILabel = {
        return Utilities.makeLabel(title: nil, weight: .medium, size: 18, alignment: .center)
    }()
    
    private lazy var infoBarTitleLabelC: UILabel = {
        let label = Utilities.makeLabel(title: "Title Label C", weight: .light, size: 15, alignment: .center)
        label.textColor = #colorLiteral(red: 0.8390320539, green: 0.8525128961, blue: 0.8612788916, alpha: 0.7811162243)
        return label
    }()
    
    public lazy var infoBarDataLabelC: UILabel = {
        return Utilities.makeLabel(title: nil, weight: .medium, size: 18, alignment: .center)
    }()
    
    private lazy var learnMore: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 20)
        btn.setTitle("Learn More", for: .normal)
        btn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        btn.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btn.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btn.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: -5, bottom: 0, right: 5)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        btn.tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        return btn
    }()
    
    //MARK: -- Methods
    
    public func configureSpecificViewInfo(
        titleLabelStr: String,
        infoBarTitleLabelAStr: String,
        infoBarTitleLabelBStr: String,
        infoBarTitleLabelCStr: String) {
        titleLabel.text = titleLabelStr.uppercased()
        infoBarTitleLabelA.text = infoBarTitleLabelAStr.capitalized
        infoBarTitleLabelB.text = infoBarTitleLabelBStr.capitalized
        infoBarTitleLabelC.text = infoBarTitleLabelCStr.capitalized
    }
    
    public func setViewElementsFromSpeciesData(species: Species) {}
    
    private func setAppearance() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 39
        self.clipsToBounds = true
        self.addBlurToView(cornerRadius: 39)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAppearance()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//MARK: -- Adding Subviews & Constraints
extension DetailInfoPanelView {
    
    private func addSubviews() {
        let UIElements =  [titleLabel, infoBarView, bodyTextView, learnMore]
        UIElements.forEach{ self.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let infoBarElements = [infoBarTitleLabelA, infoBarDataLabelA, infoBarTitleLabelB, infoBarDataLabelB, infoBarTitleLabelC, infoBarDataLabelC]
        infoBarElements.forEach { infoBarView.addSubview($0) }
        infoBarElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
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
    
    private func setOverviewTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setInfoBarConstraints() {
        NSLayoutConstraint.activate([
            infoBarView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            infoBarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            infoBarView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.18),
            infoBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setInfoBarTitleLabelAConstraints() {
        NSLayoutConstraint.activate([
            infoBarTitleLabelA.topAnchor.constraint(equalTo: infoBarView.topAnchor, constant: 10),
            infoBarTitleLabelA.centerXAnchor.constraint(equalTo: infoBarDataLabelA.centerXAnchor),
            infoBarTitleLabelA.heightAnchor.constraint(equalToConstant: 20),
            infoBarTitleLabelA.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setInfoBarDataLabelAConstraints() {
        NSLayoutConstraint.activate([
            infoBarDataLabelA.topAnchor.constraint(equalTo: infoBarTitleLabelA.bottomAnchor, constant: 5),
            infoBarDataLabelA.leadingAnchor.constraint(equalTo: infoBarView.leadingAnchor, constant: 15),
            infoBarDataLabelA.heightAnchor.constraint(equalToConstant: 30),
            infoBarDataLabelA.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setInfoBarTitleLabelBConstraints() {
        NSLayoutConstraint.activate([
            infoBarTitleLabelB.topAnchor.constraint(equalTo: infoBarTitleLabelA.topAnchor),
            infoBarTitleLabelB.centerXAnchor.constraint(equalTo: infoBarDataLabelB.centerXAnchor),
            infoBarTitleLabelB.heightAnchor.constraint(equalTo: infoBarTitleLabelA.heightAnchor),
            infoBarTitleLabelB.widthAnchor.constraint(equalTo: infoBarTitleLabelA.widthAnchor)
        ])
    }
    
    private func setInfoBarDataLabelBConstraints() {
        NSLayoutConstraint.activate([
            infoBarDataLabelB.topAnchor.constraint(equalTo: infoBarDataLabelA.topAnchor),
            infoBarDataLabelB.leadingAnchor.constraint(equalTo: infoBarDataLabelA.trailingAnchor, constant: 15),
            infoBarDataLabelB.heightAnchor.constraint(equalTo: infoBarDataLabelA.heightAnchor),
            infoBarDataLabelB.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setInfoBarTitleLabelCConstraints() {
        NSLayoutConstraint.activate([
            infoBarTitleLabelC.topAnchor.constraint(equalTo: infoBarTitleLabelA.topAnchor),
            infoBarTitleLabelC.centerXAnchor.constraint(equalTo: infoBarDataLabelC.centerXAnchor),
            infoBarTitleLabelC.heightAnchor.constraint(equalTo: infoBarTitleLabelA.heightAnchor),
            infoBarTitleLabelC.widthAnchor.constraint(equalTo: infoBarTitleLabelA.widthAnchor)
        ])
    }
    
    private func setInfoBarDataLabelCConstraints() {
        NSLayoutConstraint.activate([
            infoBarDataLabelC.topAnchor.constraint(equalTo: infoBarDataLabelA.topAnchor),
            infoBarDataLabelC.trailingAnchor.constraint(equalTo: infoBarView.trailingAnchor, constant: -15),
            infoBarDataLabelC.heightAnchor.constraint(equalTo: infoBarDataLabelA.heightAnchor),
            infoBarDataLabelC.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setBodyTextViewConstraints() {
        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: infoBarView.bottomAnchor, constant: 15),
            bodyTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            bodyTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setReadMoreButtonConstraints() {
        NSLayoutConstraint.activate([
            learnMore.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            learnMore.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            learnMore.heightAnchor.constraint(equalToConstant: 40),
            learnMore.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
}

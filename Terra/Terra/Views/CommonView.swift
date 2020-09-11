//
//  CommonView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/15/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

///Shared between DetailInfoVC and CoverRoundedCell
final class CommonView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var titleLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      fontWeight: .black,
                                      fontSize: 36,
                                      widthAdjustsFontSize: true,
                                      color: .white,
                                      alignment: .left)
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      fontWeight: .bold,
                                      fontSize: Constants.FontHierarchy.secondaryContentFontSize,
                                      widthAdjustsFontSize: true,
                                      color: .white,
                                      alignment: .left)
        label.alpha = 0
        return label
        
    }()
    
    
    
    private lazy var blurbLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      fontWeight: .regular,
                                      fontSize: Constants.FontHierarchy.secondaryContentFontSize,
                                      widthAdjustsFontSize: true,
                                      color: .darkGray,
                                      alignment: .left)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var backgroundImageTopGradient: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 0.05166878551, green: 0.05191607028, blue: 0.05249153823, alpha: 0.7)
        gv.endColor = .clear
        return gv
    }()
    
    
    //MARK: -- Properties
    
    var strategy: DetailPageStrategy!
    
    private lazy var titleTopConstraint: NSLayoutConstraint = {
        return titleLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.spacing)
    }()
    
    var topConstraintValue: CGFloat {
        get { return titleTopConstraint.constant }
        set { titleTopConstraint.constant = newValue }
    }
    //MARK: -- Methods
    
    func fadeSubtitleIn() {
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.subtitleLabel.alpha = 1
        }
    }
    
    func fadeSubtitleOut() {
        UIView.animate(withDuration: 0.7) { [weak self] in
            guard let self = self else { return }
            self.subtitleLabel.alpha = 0
        }
    }
    
    
    func configureView(from strategy: DetailPageStrategy) {
        titleLabel.text = strategy.pageName
        subtitleLabel.text = strategy.species.commonName
        
        guard let firebaseManager = strategy.firebaseStorageManager else {
            backgroundImage.image = #imageLiteral(resourceName: "HowToHelp")
            return
        }
        firebaseManager.getImage(for: strategy.species.commonName, setTo: backgroundImage)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insetsLayoutMarginsFromSafeArea = false
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: -- Add Subviews & Constraints

fileprivate extension CommonView {
    func addSubviews() {
        [backgroundImage, titleLabel, subtitleLabel, blurbLabel].forEach { addSubview($0) }
        backgroundImage.addSubview(backgroundImageTopGradient)
    }
    
    func setConstraints() {
        setTitleLabelConstraints()
        setSubtitleLabelConstraints()
        setBlurbLabelConstraints()
        setBackgroundImageConstraints()
        setBackgroundImageTopGradientConstraints()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            titleTopConstraint.isActive = true
            make.leading.trailing.equalTo(self).inset(Constants.spacing)
        }
    }
    
    func setSubtitleLabelConstraints() {
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing/2)
            make.leading.equalTo(titleLabel).inset(3.5)
        }
    }
    
    
    
    func setBlurbLabelConstraints() {
        blurbLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.leading.bottom.trailing.equalTo(self).inset(Constants.spacing)
        }
    }
    
    func setBackgroundImageConstraints() {
        backgroundImage.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.centerY.centerX.equalTo(self)
            make.height.width.equalTo(Constants.commonViewSize)
        }
    }
    
    func setBackgroundImageTopGradientConstraints() {
        backgroundImageTopGradient.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(backgroundImage)
            make.height.equalTo(backgroundImage.snp.height).multipliedBy(0.35)
        }
    }
}

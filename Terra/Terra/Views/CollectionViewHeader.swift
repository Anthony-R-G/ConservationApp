//
//  CollectionHeaderView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/11/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {
    //MARK: UI Element Initialization
    
    private lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var headerGradient: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 0.09561876208, green: 0.09505801648, blue: 0.09605474025, alpha: 0.5088827055)
        gv.endColor = .clear
        return gv
    }()
    
    private lazy var visualEffectView: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    }()
    
    private lazy var titleLabel: UILabel = {
        return Factory.makeLabel(title: "Amur Leopard",
                                 weight: .bold,
                                 size: 25,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var subtitleLabel: UILabel = {
        return Factory.makeLabel(title: "Panthers pardus orientalis",
                                 weight: .lightItalic,
                                 size: 14,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, subtitleLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    //MARK: -- Properties
    
    var animator: UIViewPropertyAnimator!
    
    
    //MARK: -- Methods
    
    func configureViewFromSpecies(species: Species) {
        titleLabel.text = species.commonName
        subtitleLabel.text = species.taxonomy.scientificName
        FirebaseStorageService.learnMoreOverviewImageManager.getImage(for: species.commonName, setTo: headerImageView)
    }
    
    private func setupVisualEffectBlur() {
        addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.edges.equalTo(self)
        }
        
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: { [weak self] in
            guard let self = self else { return }
            self.visualEffectView.effect = nil
        })
        animator.pausesOnCompletion = true
        animator.isReversed = true
        animator.fractionComplete = 0
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.darkGray.cgColor]
        gradientLayer.locations = [0.5, 1]
        
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.snp.makeConstraints {[weak self] (make) in
            guard let self = self else { return }
            make.leading.bottom.trailing.equalTo(self)
        }
        gradientContainerView.layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = bounds
        gradientLayer.frame.origin.y -= bounds.height
        
        
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, subtitleLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        stackView.snp.makeConstraints { [weak self ](make) in
            guard let self = self else { return }
            make.leading.bottom.trailing.equalTo(self).inset(20)
        }
        addParallaxToView(vw: headerImageView)
        addParallaxToView(vw: stackView)
    }
    
    func addParallaxToView(vw: UIView) {
        let amount = 40

        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount

//        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
//        vertical.minimumRelativeValue = -amount
//        vertical.maximumRelativeValue = amount

        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal]
        vw.addMotionEffect(group)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        addSubview(headerImageView)
        setConstraints()
        
        setupVisualEffectBlur()
        
        setupGradientLayer()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension CollectionViewHeader {
    
    func setConstraints() {
        setHeaderImageViewConstraints()
//        setHeaderGradientConstraints()
    }
    
    
    func setHeaderImageViewConstraints() {
        headerImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setHeaderGradientConstraints() {
        headerGradient.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(headerImageView)
            make.height.equalTo(headerImageView.snp.height).multipliedBy(0.25)
        }
    }
}


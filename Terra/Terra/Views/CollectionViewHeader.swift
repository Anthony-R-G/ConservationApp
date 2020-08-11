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
        iv.image = #imageLiteral(resourceName: "amurleopard")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var headerGradient: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 0.09561876208, green: 0.09505801648, blue: 0.09605474025, alpha: 0.5088827055)
        gv.endColor = .clear
        return gv
    }()
    
    private lazy var bottomGradient: UIView = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.darkGray.cgColor]
        gradientLayer.locations = [0.5, 1]
        
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        
        gradientContainerView.layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = self.bounds
        
        gradientLayer.frame.origin.y -= bounds.height
        return gradientContainerView
    }()
    
    private lazy var visualEffectView: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    }()
    
    //MARK: -- Properties
    var animator: UIViewPropertyAnimator!
    
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
        
        animator.isReversed = true
        animator.fractionComplete = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        addSubviews()
        setConstraints()
        
        setupVisualEffectBlur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension CollectionViewHeader {
    
    func addSubviews() {
        addSubview(headerImageView)
        headerImageView.addSubview(headerGradient)
    }
    
    func setConstraints() {
        setHeaderImageViewConstraints()
        setHeaderGradientConstraints()
        setBottomGradientConstraints()
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
    
    func setBottomGradientConstraints() {
        bottomGradient.snp.makeConstraints {[weak self] (make) in
            guard let self = self else { return }
            make.leading.bottom.trailing.equalTo(self)
        }
    }
}

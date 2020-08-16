//
//  CommonView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/15/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class CommonView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var titleLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      weight: .black,
                                      size: 36,
                                      color: .white,
                                      alignment: .left)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      weight: .bold,
                                      size: 16,
                                      color: #colorLiteral(red: 0.4823529412, green: 0.4823529412, blue: 0.4823529412, alpha: 1),
                                      alignment: .left)
        return label
    }()
    
    private lazy var blurbLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      weight: .regular,
                                      size: 16,
                                      color: .darkGray,
                                      alignment: .left)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "wwdc")
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var backgroundImageTopGradient: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 0.05166878551, green: 0.05191607028, blue: 0.05249153823, alpha: 0.6392069777)
        gv.endColor = .clear
        return gv
    }()
    
    private lazy var backgroundImageBottomGradient: GradientView = {
           let gv = GradientView()
           gv.startColor = .clear
           gv.endColor = #colorLiteral(red: 0.1944729984, green: 0.2008640766, blue: 0.2050628662, alpha: 0.5)
           return gv
       }()
    
    
    //MARK: -- Properties
    var strategy: LearnMoreVCStrategy!
    
    private lazy var topConstraint: NSLayoutConstraint = {
        return subtitleLabel.topAnchor.constraint(equalTo: topAnchor,
                                                  constant: Constants.spacingConstant)
    }()
    
    var topConstraintValue: CGFloat {
        get { return topConstraint.constant }
        set { topConstraint.constant = newValue }
    }
    //MARK: -- Methods
    
    func configureView(from strategy: LearnMoreVCStrategy) {
        titleLabel.text = strategy.subtitle()
        strategy.firebaseStorageManager().getImage(for: strategy.species.commonName, setTo: backgroundImage)
//        subtitleLabel.text = "NOW TRENDING"
//        blurbLabel.text = "The event brings together creators and dreamers of all ages"
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
//        setBackgroundImageBottomGradientConstraints()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.spacingConstant/2)
            make.leading.trailing.equalTo(self).inset(Constants.spacingConstant)
        }
    }
    
//    func setTitleLabelConstraints() {
//        titleLabel.snp.makeConstraints {[weak self] (make) in
//            guard let self = self else { return }
//            make.leading.trailing.bottom.equalTo(self).inset(Constants.spacingConstant)
//        }
//    }
    
    func setSubtitleLabelConstraints() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacingConstant),
            topConstraint
        ])
    }
    
    func setBlurbLabelConstraints() {
        blurbLabel.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.leading.bottom.trailing.equalTo(self).inset(Constants.spacingConstant)
        }
    }
    
    func setBackgroundImageConstraints() {
        backgroundImage.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.centerY.centerX.equalTo(self)
            make.height.width.equalTo(Constants.commonViewImageDimension)
        }
    }
    
    func setBackgroundImageTopGradientConstraints() {
        backgroundImageTopGradient.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(backgroundImage)
            make.height.equalTo(backgroundImage.snp.height).multipliedBy(0.30)
        }
    }
    
    func setBackgroundImageBottomGradientConstraints() {
         backgroundImageBottomGradient.snp.makeConstraints { (make) in
             make.leading.top.bottom.trailing.equalTo(backgroundImage)
         }
     }
}

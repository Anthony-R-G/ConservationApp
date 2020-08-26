//
//  CircleBlurButton.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class CircleBlurButton: UIButton {
    //MARK: -- UI Element Initialization
    private lazy var visualEffectView: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blur.frame = bounds
        blur.layer.cornerRadius = 0.5 * bounds.size.width
        blur.clipsToBounds = true
        blur.isUserInteractionEnabled = false
        return blur
    }()
    
    private lazy var buttonImage: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = #colorLiteral(red: 0.1041717753, green: 0.1035600975, blue: 0.1046468541, alpha: 0.796473673)
        return iv
    }()
    
    //MARK: -- Methods
    
    private func commonInit() {
        layer.cornerRadius = 0.5 * self.bounds.size.width
        clipsToBounds = true
    }
    
    required init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        self.buttonImage.image = image
        commonInit()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension CircleBlurButton {
    
    func addSubviews() {
        addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(buttonImage)
    }
    
    func setConstraints() {
        setVisualEffectViewConstraints()
        setButtonImageConstraints()
    }
    
    func setVisualEffectViewConstraints() {
        visualEffectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setButtonImageConstraints() {
        buttonImage.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            if buttonImage.image == UIImage(systemName: "xmark") {
                make.width.equalToSuperview().multipliedBy(0.60)
                make.height.equalToSuperview().multipliedBy(0.70)
            } else {
                make.width.height.equalToSuperview().multipliedBy(0.70)
            }
        }
    }
}

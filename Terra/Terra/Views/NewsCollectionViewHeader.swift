//
//  NewsCollectionViewHeader.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/29/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class NewsCollectionViewHeader: UICollectionReusableView {
    //MARK: UI Element Initialization
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var backgroundVisualEffectView: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    }()
    
    private lazy var backgroundDarkOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4008989726)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontWeight.bold.rawValue, size: 32)
        label.textColor = .white
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .regular,
                                 size: 14,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var headerShareButton: UIButton = {
        return Factory.makeBlurredCircleButton(image: .share, style: .dark)
    }()
    
    
    //MARK: -- Properties
    var animator: UIViewPropertyAnimator!
    
     func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: { [weak self] in
            guard let self = self else { return }
            self.backgroundVisualEffectView.effect = nil
        })
        
        animator.isReversed = true
        animator.fractionComplete = 0
    }
    
    func configureHeader(from article: NewsArticle) {
        titleLabel.text = article.title
        subtitleLabel.text = article.publishedAt
        backgroundImageView.sd_setImage(with: URL(string: article.urlToImage!), placeholderImage: #imageLiteral(resourceName: "black"))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupVisualEffectBlur()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension NewsCollectionViewHeader {
    
    func addSubviews() {
        [backgroundImageView, backgroundVisualEffectView, backgroundDarkOverlay, titleLabel, subtitleLabel, headerShareButton]
            .forEach { addSubview($0) }
    }
    
    func setConstraints() {
        setHeaderImageViewConstraints()
        setHeaderVisualEffectViewConstraints()
        setHeaderDarkOverlayConstraints()
        setHeaderTitleConstraints()
        setHeaderPublishedDateConstraints()
        setHeaderShareButtonConstraints()
    }
    
    
    func setHeaderImageViewConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setHeaderDarkOverlayConstraints() {
        backgroundDarkOverlay.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setHeaderTitleConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview().inset(Constants.spacing)
            make.bottom.equalTo(subtitleLabel.snp.top).inset(Constants.spacing)
            make.centerY.equalToSuperview()
        }
    }
    
    func setHeaderPublishedDateConstraints() {
        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(Constants.spacing)
        }
    }
    
    func setHeaderShareButtonConstraints() {
        headerShareButton.snp.makeConstraints { (make) in
            make.leading.equalTo(subtitleLabel.snp.trailing).offset(Constants.spacing)
            make.centerY.equalTo(subtitleLabel)
        }
    }
    
    func setHeaderVisualEffectViewConstraints() {
        backgroundVisualEffectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

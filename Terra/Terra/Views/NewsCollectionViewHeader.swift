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
    
    private lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var visualEffectView: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    }()
    
    private lazy var headerDarkOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4008989726)
        return view
    }()
    
    private lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontWeight.bold.rawValue, size: 32)
        label.textColor = .white
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var headerPublishedDate: UILabel = {
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
    
    private func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: { [weak self] in
            guard let self = self else { return }
            self.visualEffectView.effect = nil
        })
        
        animator.isReversed = true
        animator.fractionComplete = 0
    }
    
    func configureHeader(from article: NewsArticle) {
        headerTitle.text = article.title
        headerPublishedDate.text = article.publishedAt
        headerImageView.sd_setImage(with: URL(string: article.urlToImage!), placeholderImage: #imageLiteral(resourceName: "black"))
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
        [headerImageView, visualEffectView, headerDarkOverlay, headerTitle, headerPublishedDate, headerShareButton].forEach { addSubview($0) }
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
        headerImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setHeaderDarkOverlayConstraints() {
        headerDarkOverlay.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setHeaderTitleConstraints() {
        headerTitle.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview().inset(Constants.spacing)
            make.bottom.equalTo(headerPublishedDate.snp.top).inset(Constants.spacing)
            make.centerY.equalToSuperview()
        }
    }
    
    func setHeaderPublishedDateConstraints() {
        headerPublishedDate.snp.makeConstraints { (make) in
            make.leading.equalTo(headerTitle)
            make.bottom.equalToSuperview().inset(Constants.spacing)
        }
    }
    
    func setHeaderShareButtonConstraints() {
        headerShareButton.snp.makeConstraints { (make) in
            make.leading.equalTo(headerPublishedDate.snp.trailing).offset(Constants.spacing)
            make.centerY.equalTo(headerPublishedDate)
        }
    }
    
    func setHeaderVisualEffectViewConstraints() {
        visualEffectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

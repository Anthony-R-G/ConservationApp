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
    
    private lazy var backgroundDarkOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4867026969)
        return view
    }()
    
    private lazy var backgroundVisualEffectView: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    }()
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "TODAY"
        label.font = UIFont(name: FontWeight.black.rawValue, size: 36)
        label.textAlignment = .left
        label.textColor = Constants.Color.titleLabelColor
        return label
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7024026113)
        return view
    }()
    
    private lazy var headlineTitleContainer: UIView = {
        return UIView()
    }()
    
    private lazy var headlineTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontWeight.bold.rawValue, size: 27)
        label.textColor = .white
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var headlinePublishedDateLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .regular,
                                 size: 14,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var shareButton: UIButton = {
        return Factory.makeBlurredCircleButton(image: .share, style: .dark)
    }()
    
    private lazy var refreshButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .white
        return button
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
        headlineTitleLabel.text = article.title
        headlinePublishedDateLabel.text = article.publishedAt
        backgroundImageView.sd_setImage(with: URL(string: article.urlToImage!), placeholderImage: #imageLiteral(resourceName: "black"))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        clipsToBounds = true
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
        [backgroundImageView, backgroundVisualEffectView, backgroundDarkOverlay, todayLabel, headlineTitleContainer, separatorLine, headlinePublishedDateLabel, shareButton, refreshButton]
            .forEach { addSubview($0) }
        headlineTitleContainer.addSubview(headlineTitleLabel)
    }
    
    func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundVisualEffectViewConstraints()
        setBackgroundDarkOverlayConstraints()
        
        setTodayLabelConstraints()
        setSeparatorLineConstraints()
        setHeadlineContainerConstraints()
        setHeadlineTitleLabelConstraints()
        setHeadlinePublishedDateLabelConstraints()
        
        setShareButtonConstraints()
        setRefreshButtonConstraints()
    }
    
    func setBackgroundImageViewConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setBackgroundVisualEffectViewConstraints() {
        backgroundVisualEffectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setBackgroundDarkOverlayConstraints() {
        backgroundDarkOverlay.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setTodayLabelConstraints() {
        todayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).inset(Constants.spacing)
            make.leading.equalToSuperview().inset(Constants.spacing)
        }
    }
    
    func setSeparatorLineConstraints() {
        separatorLine.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.90)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(todayLabel.snp.bottom).offset(Constants.spacing/2)
        }
    }
    
    func setHeadlineContainerConstraints() {
        headlineTitleContainer.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(Constants.spacing)
            make.top.equalTo(separatorLine.snp.bottom)
            make.bottom.equalTo(headlinePublishedDateLabel.snp.top)
        }
    }
    
    func setHeadlineTitleLabelConstraints() {
        headlineTitleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setHeadlinePublishedDateLabelConstraints() {
        headlinePublishedDateLabel.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview().inset(Constants.spacing)
        }
    }
    
    func setShareButtonConstraints() {
        shareButton.snp.makeConstraints { (make) in
            make.leading.equalTo(headlinePublishedDateLabel.snp.trailing).offset(Constants.spacing)
            make.centerY.equalTo(headlinePublishedDateLabel)
        }
    }
    
    func setRefreshButtonConstraints() {
        refreshButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Constants.spacing)
            make.centerY.equalTo(todayLabel)
            make.height.width.equalTo(35)
        }
    }
}

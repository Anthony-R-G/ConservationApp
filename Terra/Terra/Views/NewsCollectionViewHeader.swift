//
//  NewsCollectionViewHeader.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/29/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class NewsCollectionViewHeader: UICollectionReusableView {
    static var reuseIdentifier: String { 
        return String(describing: NewsCollectionViewHeader.self)
    }
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
        return Factory.makeLabel(title: "TODAY",
                                 fontWeight: .black,
                                 fontSize: 36,
                                 widthAdjustsFontSize: false,
                                 color: Constants.Color.titleLabelColor,
                                 alignment: .left)
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7024026113)
        return view
    }()
    
    private lazy var headlineTitleContainer: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var headlineTitleLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                      fontWeight: .bold,
                                      fontSize: Constants.FontHierarchy.primaryContentFontSize,
                                      widthAdjustsFontSize: false,
                                      color: .white,
                                      alignment: .left)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 4
        return label
    }()
    
    private lazy var headlinePublishedDateLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 fontWeight: .regular,
                                 fontSize: 14,
                                 widthAdjustsFontSize: true,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var shareButton: UIButton = {
        let btn = Factory.makeBlurredCircleButton(image: .share, style: .dark, size: .regular)
        btn.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var refreshButton: LoadingButton = {
        let btn = LoadingButton()
        btn.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(headerTapped))
    }()
    
    
    //MARK: -- Properties
    var animator: UIViewPropertyAnimator!
    
    weak var delegate: NewsHeaderDelegate?
    
    //MARK: -- Methods
    
    @objc private func refreshButtonTapped() {
        refreshButton.showLoader()
        delegate?.refreshButtonTapped()
    }
    
    func stopButtonLoading() {
        refreshButton.hideLoader()
    }
    
    @objc private func shareButtonTapped() {
        delegate?.shareButtonTapped()
    }
    
    
    @objc private func headerTapped() {
        delegate?.headerLabelTapped()
    }
    
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
        guard article.urlToImage != nil else {
            backgroundImageView.image = #imageLiteral(resourceName: "african-savannah_cropped")
            return
        }
        backgroundImageView.sd_setImage(with: URL(string: article.urlToImage!), placeholderImage: #imageLiteral(resourceName: "black"))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        clipsToBounds = true
        setupVisualEffectBlur()
        addSubviews()
        setConstraints()
        headlineTitleContainer.addGestureRecognizer(tapGesture)
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
            make.top.equalTo(safeAreaLayoutGuide).inset(Constants.padding)
            make.leading.equalToSuperview().inset(Constants.padding)
            make.height.equalTo(30)
        }
    }
    
    func setSeparatorLineConstraints() {
        separatorLine.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(Constants.padding)
            make.height.equalTo(1)
            make.top.equalTo(todayLabel.snp.bottom).offset(Constants.padding/2)
        }
    }
    
    func setHeadlineContainerConstraints() {
        headlineTitleContainer.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(Constants.padding)
            make.top.equalTo(separatorLine.snp.bottom)
            make.bottom.equalTo(headlinePublishedDateLabel.snp.top).inset(-Constants.padding/2)
        }
    }
    
    func setHeadlineTitleLabelConstraints() {
        headlineTitleLabel.snp.makeConstraints { (make) in
            make.leading.centerY.height.trailing.equalToSuperview()
        }
    }
    
    func setHeadlinePublishedDateLabelConstraints() {
        headlinePublishedDateLabel.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview().inset(Constants.padding)
        }
    }
    
    func setShareButtonConstraints() {
        shareButton.snp.makeConstraints { (make) in
            make.leading.equalTo(headlinePublishedDateLabel.snp.trailing).offset(Constants.padding)
            make.centerY.equalTo(headlinePublishedDateLabel)
        }
    }
    
    func setRefreshButtonConstraints() {
        refreshButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Constants.padding)
            make.centerY.equalTo(todayLabel)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
}

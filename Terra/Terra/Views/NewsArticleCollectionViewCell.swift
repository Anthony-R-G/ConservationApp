//
//  NewsArticleTableViewCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/3/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class NewsArticleCollectionViewCell: UICollectionViewCell {
    //MARK: -- UI Element Initialization
    
    private lazy var articleThumbImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        return iv
    }()
    
    private lazy var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontWeight.bold.rawValue, size: 18)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var publishedDateLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .regular,
                                 size: 14,
                                 color: .lightGray,
                                 alignment: .left)
        
    }()
    
    private lazy var articleTitleContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var shareButton: UIButton = {
        let button = Factory.makeBlurredCircleButton(image: .share, style: .dark)
        button.addTarget(self, action: #selector(shareButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: -- Properties
    
    weak var delegate: NewsCellDelegate?
    
    //MARK: -- Methods
    
    @objc private func shareButtonTapped(sender: UIButton) {
        delegate?.shareButtonTapped(sender: sender)
    }
    
    func configureCell(from article: NewsArticle) {
        guard let articleImageURL = article.urlToImage else {
            articleThumbImageView.image = #imageLiteral(resourceName: "News Image Placeholder")
            return
        }
        articleTitleLabel.text = article.title
        publishedDateLabel.text = article.publishedAt
        articleThumbImageView.sd_setImage(with: URL(string: articleImageURL), completed: nil)
    }
    
    private func setAppearance() {
        backgroundColor = #colorLiteral(red: 0.1333159208, green: 0.1333422065, blue: 0.1333123744, alpha: 1)
        layer.cornerRadius = 10
        clipsToBounds = true
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.08120436221, green: 0.09556283802, blue: 0.1183818057, alpha: 1)
        selectedBackgroundView = bgColorView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension NewsArticleCollectionViewCell {
    
    func addSubviews() {
        [articleThumbImageView, articleTitleContainer, publishedDateLabel, shareButton]
            .forEach{ addSubview($0) }
        articleTitleContainer.addSubview(articleTitleLabel)
    }
    
    func setConstraints() {
        setArticleThumbImageViewConstraints()
        setArticleTitleContainerConstraints()
        setArticleTitleLabelConstraints()
        setPublishedDateLabelConstraints()
        setShareButtonConstraints()
    }
    
    func setArticleThumbImageViewConstraints() {
        articleThumbImageView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(160)
        }
    }
    
    func setArticleTitleContainerConstraints() {
        articleTitleContainer.snp.makeConstraints { (make) in
            make.leading.equalTo(articleThumbImageView.snp.trailing).offset(Constants.spacing/2)
            make.top.trailing.equalToSuperview().inset(Constants.spacing/2)
            make.bottom.equalTo(publishedDateLabel.snp.top).inset(-Constants.spacing/2)
        }
    }
    
    func setArticleTitleLabelConstraints() {
        articleTitleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(articleTitleContainer)
            make.height.equalToSuperview()
            make.centerY.equalTo(articleTitleContainer)
        }
    }
    
    func setPublishedDateLabelConstraints() {
        publishedDateLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(articleTitleContainer)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(Constants.spacing/2)
        }
    }
    
    func setShareButtonConstraints() {
        shareButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Constants.spacing)
            make.centerY.equalTo(publishedDateLabel)
        }
    }
}

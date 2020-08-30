//
//  NewsArticleTableViewCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/3/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

protocol ShareButtonDelegate: AnyObject {
    func shareButtonTapped(sender: UIButton)
}

final class NewsArticleTableViewCell: UICollectionViewCell {
    //MARK: -- UI Element Initialization
    
    private lazy var articleThumbImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        return iv
    }()
    
    private lazy var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontWeight.bold.rawValue, size: 18)
        label.textAlignment = .left
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var publishedDateLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .regular,
                                 size: 14,
                                 color: .lightGray,
                                 alignment: .left)
        
    }()
    
    lazy var shareButton: UIButton = {
        let button = Factory.makeBlurredCircleButton(image: .share, style: .dark)
        button.addTarget(self, action: #selector(shareButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: -- Properties
    
    weak var delegate: ShareButtonDelegate?
    
    
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
        backgroundColor = .black
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
fileprivate extension NewsArticleTableViewCell {
    
    func addSubviews() {
        [articleThumbImageView, articleTitleLabel, publishedDateLabel, shareButton].forEach{ addSubview($0) }
    }
    
    func setConstraints() {
        setArticleThumbImageViewConstraints()
        setArticleTitleLabelConstraints()
        setPublishedDateLabelConstraints()
        setShareButtonConstraints()
    }
    
    func setArticleThumbImageViewConstraints() {
        articleThumbImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(Constants.spacing)
            make.centerY.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(140)
        }
    }
    
    func setArticleTitleLabelConstraints() {
        articleTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(articleThumbImageView.snp.trailing).offset(Constants.spacing)
            make.trailing.equalToSuperview().inset(Constants.spacing)
            make.bottom.equalTo(articleThumbImageView).inset(Constants.spacing)
            make.top.equalTo(articleThumbImageView)
        }
    }
    
    func setPublishedDateLabelConstraints() {
        publishedDateLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(articleTitleLabel)
            make.bottom.equalTo(articleThumbImageView)
        }
    }
    
    func setShareButtonConstraints() {
        shareButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Constants.spacing)
            make.centerY.equalTo(publishedDateLabel)
        }
    }
}

//
//  NewsArticleTableViewCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/3/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class NewsArticleTableViewCell: UITableViewCell {
    //MARK: -- UI Element Initialization
    
    lazy var articleThumbImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        return iv
    }()
    
    lazy var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontWeight.bold.rawValue, size: 18)
        label.textAlignment = .left
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    lazy var publishedDateLabel: UILabel = {
        let label = Factory.makeLabel(title: nil,
                                 weight: .regular,
                                 size: 14,
                                 color: #colorLiteral(red: 0.7764157653, green: 0.7718015909, blue: 0.7799633741, alpha: 1),
                                 alignment: .left)
//        label.backgroundColor = .purple
        return label
    }()
    
    //MARK: -- Methods
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        [articleThumbImageView, articleTitleLabel, publishedDateLabel].forEach{ addSubview($0) }
    }
    
    func setConstraints() {
        setArticleThumbImageViewConstraints()
        setArticleTitleLabelConstraints()
        setPublishedDateLabelConstraints()
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
}

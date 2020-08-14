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
        let label = Factory.makeLabel(title: nil,
                                      weight: .bold,
                                      size: 18,
                                      color: .white,
                                      alignment: .left)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var publishedDateLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .medium,
                                 size: 15,
                                 color: #colorLiteral(red: 0.6783636212, green: 0.6784659028, blue: 0.6783496737, alpha: 1),
                                 alignment: .left)
    }()
    
    //MARK: -- Methods
    
    func configureCell(from article: NewsArticle) {
        guard let articleImageURL = article.urlToImage else {
            articleThumbImageView.image = #imageLiteral(resourceName: "newsImagePlaceholder")
            return
        }
        articleTitleLabel.text = article.title
        publishedDateLabel.text = article.formattedPublishDate
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
        let UIElements = [articleThumbImageView, articleTitleLabel, publishedDateLabel]
        UIElements.forEach{ addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setArticleThumbImageViewConstraints()
        setArticleTitleLabelConstraints()
        setPublishedDateLabelConstraints()
    }
    
    func setArticleThumbImageViewConstraints() {
        articleThumbImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(Constants.spacingConstant)
            make.centerY.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(140)
        }
    }
    
    func setArticleTitleLabelConstraints() {
        articleTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(articleThumbImageView.snp.trailing).offset(Constants.spacingConstant)
            make.top.trailing.equalToSuperview().inset(Constants.spacingConstant)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    func setPublishedDateLabelConstraints() {
        publishedDateLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(articleTitleLabel)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

//
//  NewsArticleTableViewCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/3/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class NewsArticleTableViewCell: UITableViewCell {
    //MARK: -- UI Element Initialization
    
    lazy var articleThumbImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .clear
        return iv
    }()
    
    lazy var articleTitleLabel: UILabel = {
        let label = Factory.makeLabel(title: nil, weight: .bold, size: 18, color: .black, alignment: .left)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var publishedDateLabel: UILabel = {
        return Factory.makeLabel(title: nil, weight: .medium, size: 15, color: #colorLiteral(red: 0.6783636212, green: 0.6784659028, blue: 0.6783496737, alpha: 1), alignment: .left)
    }()
    
    
    //MARK: -- Methods
    
    func configureCellUI(from article: Article) {
        let articleThumbImageURL = URL(string: article.urlToImage)
        articleThumbImageView.sd_setImage(with: articleThumbImageURL, completed: nil)
        articleTitleLabel.text = article.title
        publishedDateLabel.text = article.formattedPublishDate
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
        backgroundColor = .white
        
//        let bgColorView = UIView()
//        bgColorView.backgroundColor = #colorLiteral(red: 0.06663120538, green: 0.07717584819, blue: 0.1243596151, alpha: 1)
//        selectedBackgroundView = bgColorView
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
        NSLayoutConstraint.activate([
            articleThumbImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            articleThumbImageView.heightAnchor.constraint(equalToConstant: 120),
            articleThumbImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            articleThumbImageView.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    func setArticleTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            articleTitleLabel.leadingAnchor.constraint(equalTo: articleThumbImageView.trailingAnchor, constant: 20),
            articleTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            articleTitleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            articleTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setPublishedDateLabelConstraints() {
        NSLayoutConstraint.activate([
            publishedDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            publishedDateLabel.leadingAnchor.constraint(equalTo: articleTitleLabel.leadingAnchor),
            publishedDateLabel.heightAnchor.constraint(equalToConstant: 40),
            publishedDateLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}

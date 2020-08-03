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
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        return iv
    }()
    
    lazy var articleTitleLabel: UILabel = {
        return Factory.makeLabel(title: nil, weight: .bold, size: 20, color: .white, alignment: .left)
    }()
    
    
    //MARK: -- Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
        backgroundColor = #colorLiteral(red: 0.1082275882, green: 0.1245508119, blue: 0.1976556778, alpha: 1)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.06663120538, green: 0.07717584819, blue: 0.1243596151, alpha: 1)
        selectedBackgroundView = bgColorView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension NewsArticleTableViewCell {
    
    func addSubviews() {
        let UIElements = [articleThumbImageView, articleTitleLabel]
        UIElements.forEach{ addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setArticleThumbImageViewConstraints()
        setArticleTitleLabelConstraints()
    }
    
    func setArticleThumbImageViewConstraints() {
        NSLayoutConstraint.activate([
            articleThumbImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            articleThumbImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            articleThumbImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setArticleTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            articleTitleLabel.leadingAnchor.constraint(equalTo: articleThumbImageView.trailingAnchor, constant: 20),
            articleTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            articleTitleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }
    
}

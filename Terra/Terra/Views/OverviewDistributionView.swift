//
//  OverviewDistributionView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class OverviewDistributionView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TITLE"
        //        label.backgroundColor = .purple
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = Constants.titleLabelColor
        label.numberOfLines = 0
        return label
    }()
    
    lazy var mapImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "amurLeopardMap")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private func setContentViewBottomConstraint() {
        if let lastSubview = subviews.last {
            bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.399026113)
        layer.cornerRadius = 10
        addSubviews()
        setConstraints()
        setContentViewBottomConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -- Add Subviews & Constraints

fileprivate extension OverviewDistributionView {
    func addSubviews() {
        let UIElements = [titleLabel, mapImageView]
        UIElements.forEach { addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setTitleLabelConstraints()
        setLabelConstraints()
        
    }
    
    func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setLabelConstraints() {
        NSLayoutConstraint.activate([
            mapImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            mapImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mapImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mapImageView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
}


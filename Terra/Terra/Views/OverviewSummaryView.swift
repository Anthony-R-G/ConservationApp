//
//  OverviewSummaryView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class OverviewSummaryView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TITLE"
        label.backgroundColor = .purple
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
           let label = UILabel()
           label.backgroundColor = .yellow
           label.numberOfLines = 0
           return label
       }()
    
    private func setContentViewBottomConstraint() {
        if let lastSubview = subviews.last {
            bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setConstraints()
        setContentViewBottomConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension OverviewSummaryView {
    func addSubviews() {
        let UIElements = [titleLabel, bodyLabel]
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
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}

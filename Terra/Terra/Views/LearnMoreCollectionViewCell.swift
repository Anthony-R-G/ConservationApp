//
//  LearnMoreCollectionViewCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/11/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class LearnMoreCollectionViewCell: UICollectionViewCell {
    
    //MARK: -- UI Element Initialization
    
    private lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
     lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.layer.cornerRadius = 39
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var customTextView: UITextView = {
        let customView = UITextView()
        customView.backgroundColor = .green
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    
    fileprivate func setupViews() {
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.leading.width.equalToSuperview()
        }
        
        contentView.addSubview(customTextView)
        //        customView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        //        customView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //        customView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //        customView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        customTextView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.height.width.equalTo(200)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        contentView.layer.cornerRadius = 39
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
}

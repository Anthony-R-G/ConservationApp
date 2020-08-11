//
//  CollectionHeaderView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/11/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    private lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "amurleopard")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var headerGradient: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 0.09561876208, green: 0.09505801648, blue: 0.09605474025, alpha: 0.5088827055)
        gv.endColor = .clear
        return gv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Custom code for layout
        
        backgroundColor = .orange
        
        addSubviews()
        setConstraints()
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension CollectionHeaderView {
    
    func addSubviews() {
        addSubview(headerImageView)
        headerImageView.addSubview(headerGradient)
    }
    
    func setConstraints() {
        setHeaderImageViewConstraints()
        setHeaderGradientConstraints()
    }
    
    
     func setHeaderImageViewConstraints() {
        headerImageView.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.leading.top.trailing.bottom.equalTo(self)
        }
    }
    
    func setHeaderGradientConstraints() {
        headerGradient.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(headerImageView)
            make.height.equalTo(headerImageView.snp.height).multipliedBy(0.25)
        }
    }
}

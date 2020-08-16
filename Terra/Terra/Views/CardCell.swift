//
//  CardCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/15/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    private lazy var shadowView: ShadowView = {
        let sv = ShadowView()
        sv.backgroundColor = .clear
        return sv
    }()
    
    private lazy var commonView: CommonView = {
        let cv = CommonView()
        cv.layer.cornerRadius = 10
        cv.layer.masksToBounds = true
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: -- Add Subviews & Constraints
extension CardCell {
    func addSubviews() {
        contentView.addSubview(shadowView)
        shadowView.addSubview(commonView)
    }
    
    func setConstraints() {
        setShadowViewConstraints()
        setCommonViewConstraints()
    }
    
    func setShadowViewConstraints() {
        shadowView.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.edges.equalTo(self)
        }
    }
    
    func setCommonViewConstraints() {
        commonView.snp.makeConstraints {(make) in
            make.edges.equalTo(shadowView)
        }
    }
}

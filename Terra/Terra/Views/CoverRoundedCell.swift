//
//  RoundedInfoCell.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/15/20.
//  Copyright © 2020 Antnee. All rights reserved.
//
import UIKit

final class CoverRoundedCell: UICollectionViewCell {
    //MARK: -- UI Element Initialization
    
    private lazy var shadowView: ShadowView = {
        let sv = ShadowView()
        sv.backgroundColor = .clear
        return sv
    }()
    
    private lazy var commonView: CommonView = {
        let cv = CommonView()
        cv.layer.cornerRadius = Constants.cornerRadius
        cv.layer.masksToBounds = true
        return cv
    }()
    
    
    //MARK: -- Properties
    
    var strategy: DetailPageStrategy! {
        didSet {
            commonView.configureView(from: strategy)
        }
    }
    
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
fileprivate extension CoverRoundedCell {
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

//
//  LoadingButton.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class LoadingButton: UIButton {
    //MARK: -- UI Element Initialization
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        activityIndicator.isHidden = true
        return activityIndicator
    }()
    
    //MARK: -- Properties
    
    typealias BtnAction = (()->())?
    
    //MARK: -- Methods
    
    func showLoader() {
        isEnabled = false
        imageView?.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
        titleLabel?.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
        showSpinning()
    }
    
    func hideLoader(completion: BtnAction = nil) {
        activityIndicator.stopAnimating()
        isEnabled = true
        imageView?.layer.transform = CATransform3DIdentity
        titleLabel?.layer.transform = CATransform3DIdentity
        completion?()
    }
    
    private func showSpinning() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func setActivityIndicatorConstraints() {
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicator)
        setActivityIndicatorConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

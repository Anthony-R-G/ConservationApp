//
//  UpdatedLearnMoreViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/15/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class UpdatedLearnMoreViewController: UIViewController {
    //MARK: -- UI Element Initialization
    
    private lazy var shadowView: ShadowView = {
        let sv = ShadowView()
        sv.backgroundColor = .clear
        return sv
    }()
    
    private lazy var maskView: UIView = {
        let mv = UIView()
        mv.clipsToBounds = true
        mv.backgroundColor = .clear
        return mv
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView(frame: UIScreen.main.bounds)
        iv.backgroundColor = .black
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    
    private lazy var backgroundBlurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let bev = UIVisualEffectView(effect: blurEffect)
        bev.frame = view.bounds
        return bev
    }()
    
    private lazy var commonView: CommonView = {
        return CommonView()
    }()
    
    private lazy var bodyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var containerStackView: UIStackView = {
        return strategy.arrangedSubviews()
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
        btn.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    //MARK: -- Properties
    
    var strategy: LearnMoreVCStrategy! {
        didSet {
            commonView.configureView(from: strategy)
        }
    }
    
    private lazy var topConstraint: NSLayoutConstraint = {
        return commonView.topAnchor.constraint(equalTo: maskView.topAnchor)
    }()
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        return commonView.heightAnchor.constraint(equalToConstant: Constants.commonViewImageDimension)
    }()
    
    //MARK: -- Methods
    
    @objc private func closeButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func asCard(_ value: Bool) {
        if value {
            // Round the corners
            maskView.layer.cornerRadius = 20
        } else {
            // Round the corners
            maskView.layer.cornerRadius = 0
        }
    }
    
    private func loadImages() {
        FirebaseStorageService.detailImageManager.getImage(for: strategy.species.commonName, setTo: backgroundImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        navigationController?.navigationBar.isHidden = true
        addSubviews()
        setConstraints()
        loadImages()
    }
}

//MARK: -- Add Subviews & Constraints

extension UpdatedLearnMoreViewController {
    func addSubviews() {
        view.addSubview(shadowView)
        shadowView.addSubview(maskView)
        maskView.addSubview(backgroundImageView)
        maskView.addSubview(backgroundBlurEffectView)
        backgroundBlurEffectView.contentView.addSubview(scrollView)
        
        scrollView.addSubview(containerStackView)
        scrollView.addSubview(commonView)
        
        
        view.addSubview(closeButton)
    }
    
    func setConstraints() {
        setShadowViewConstraints()
        setMaskViewConstraints()
        
        setScrollViewConstraints()
        
        setCommonViewConstraints()
        setContainerStackView()
      
        setCloseButtonConstraints()
        setBackgroundImageConstraints()
    }
    
    func setShadowViewConstraints() {
        shadowView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func setMaskViewConstraints() {
        maskView.snp.makeConstraints { (make) in
            make.edges.equalTo(shadowView)
        }
    }
    
    func setScrollViewConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(maskView)
        }
    }
    
    func setCommonViewConstraints() {
        commonView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.leading.trailing.equalTo(maskView)
        }
        heightConstraint.isActive = true
    }
    
    func setContainerStackView() {
        containerStackView.snp.makeConstraints { (make) in
            make.top.equalTo(commonView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view).inset(20)
            make.bottom.greaterThanOrEqualTo(scrollView)
        }
    }
    
    func setCloseButtonConstraints() {
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.spacingConstant)
            make.trailing.equalToSuperview().inset(Constants.spacingConstant)
            make.height.width.equalTo(44)
        }
    }
    
    func setBackgroundImageConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

//MARK: -- Animatable Methods
extension UpdatedLearnMoreViewController: Animatable {
    var containerView: UIView? {
        return view
    }
    
    var childView: UIView? {
        return commonView
    }
    
    func presentingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect
    ) {
        // Make the common view the same size as the initial frame
        heightConstraint.constant = fromFrame.height
        
        // Show the close button
        closeButton.alpha = 1
        
        // Make the view look like a card
        asCard(true)
        
        // Redraw the view to update the previous changes
        view.layoutIfNeeded()
        
        // Push the content of the common view down to stay within the safe area insets
        let safeAreaTop = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first?.safeAreaInsets.top ?? .zero
        commonView.topConstraintValue = safeAreaTop + 16
        
        // Animate the common view to a height of 500 points
        heightConstraint.constant = 500
        sizeAnimator.addAnimations { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        }
        
        // Animate the view to not look like a card
        positionAnimator.addAnimations { [weak self] in
            guard let self = self else { return }
            self.asCard(false)
        }
    }
    
    func dismissingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect
    ) {
        // If the user has scrolled down in the content, force the common view to go to the top of the screen.
        topConstraint.isActive = true
        
        // If the top card is completely off screen, we move it to be JUST off screen.
        // This makes for a cleaner looking animation.
        if scrollView.contentOffset.y > commonView.frame.height {
            topConstraint.constant = -commonView.frame.height
            view.layoutIfNeeded()
            
            // Still want to animate the common view getting pinned to the top of the view
            topConstraint.constant = 0
        }
        
        // Common view does not need to worry about the safe area anymore. Just restore the original value.
        commonView.topConstraintValue = Constants.spacingConstant
        
        // Animate the height of the common view to be the same size as the TO frame.
        // Also animate hiding the close button
        heightConstraint.constant = toFrame.height
        sizeAnimator.addAnimations { [weak self] in
            guard let self = self else { return }
            self.closeButton.alpha = 0
            self.view.layoutIfNeeded()
        }
        
        // Animate the view to look like a card
        positionAnimator.addAnimations { [weak self] in
            guard let self = self else { return }
            self.asCard(true)
        }
    }
}


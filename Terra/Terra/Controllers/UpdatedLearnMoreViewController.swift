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
    
    private lazy var commonView: CommonView = {
        return CommonView()
    }()
    
    private lazy var bodyView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        let text = """
I am not to blame for that crown upon your head, Maggie! Giving grape juice to the juiceless. Now you pressure me, as if I might suffer the same in my unhinged soul. Maggie, there is no mercy for the juiceless. I do not even hear them. For you, Maggie, I answer only as to settle accounts and, in filling that final fraternal debit, I release you forever to your juiceless existence. All I hear now is that clockwork meowing, of yolk in those stomachs of four-headed dragons more full than mine! The Candy Mountains I must climb! The power I must grow! I do not know you, dear Maggie. Had you once who ever loved me, that Maggie would have cracked his shrinking egg open and let me feast on the yolk before begging for my share. There is much eating to be done. I must play catch up with the Sun and Moon. Do not pester me further, Maggie. Every word I speak is an grape I spill.\n\n
"""
        label.numberOfLines = 0
        label.text = text + text + text + text
        label.textColor = .black
        return label
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
            commonView.configureView(title: strategy.subtitle())
        }
    }
    
    private lazy var topConstraint: NSLayoutConstraint = {
        return commonView.topAnchor.constraint(equalTo: maskView.topAnchor)
    }()
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        return commonView.heightAnchor.constraint(equalToConstant: 500)
    }()
    
    //MARK: -- Methods
    
    @objc private func closeButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func asCard(_ value: Bool) {
        if value {
            // Round the corners
            maskView.layer.cornerRadius = 10
        } else {
            // Round the corners
            maskView.layer.cornerRadius = 0
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        addSubviews()
        setConstraints()
    }
}

//MARK: -- Add Subviews & Constraints

extension UpdatedLearnMoreViewController {
    func addSubviews() {
        view.addSubview(shadowView)
        shadowView.addSubview(maskView)
        maskView.addSubview(scrollView)
        
        scrollView.addSubview(bodyView)
        scrollView.addSubview(commonView)
        
        bodyView.addSubview(textLabel)
        
        view.addSubview(closeButton)
    }
    
    func setConstraints() {
        setShadowViewConstraints()
        setMaskViewConstraints()
        
        setScrollViewConstraints()
        
        
        setCommonViewConstraints()
        setBodyViewConstraints()
        setBodyTextConstraints()
        
        setCloseButtonConstraints()
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
    
    func setBodyViewConstraints() {
        bodyView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(commonView.snp.bottom)
            make.bottom.greaterThanOrEqualTo(scrollView)
        }
    }
    
    func setBodyTextConstraints() {
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(bodyView).inset(16)
        }
    }
    
    func setCloseButtonConstraints() {
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.spacingConstant)
            make.trailing.equalToSuperview().inset(Constants.spacingConstant)
            make.height.width.equalTo(44)
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


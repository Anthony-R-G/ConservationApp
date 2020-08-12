//
//  LearnMoreViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/10/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class LearnMoreViewController: UIViewController {
    //MARK: UI Element Initialization
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView(frame: UIScreen.main.bounds)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .black
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var backgroundBlurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let bev = UIVisualEffectView(effect: blurEffect)
        bev.frame = view.bounds
        return bev
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.delegate = self
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white
        btn.imageView?.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        btn.clipsToBounds = true
        btn.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btn.layer.cornerRadius = btn.frame.size.width / 2
        btn.backgroundColor = #colorLiteral(red: 0.1207444444, green: 0.1200340763, blue: 0.1212952659, alpha: 0.6019905822)
        btn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var imageContainer: UIView = {
        let ic = UIView()
        ic.backgroundColor = .darkGray
        return ic
    }()
    
    private lazy var headerVisualEffectBlur: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    }()
    
    private lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var headerStatusBarGradient: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 0.09561876208, green: 0.09505801648, blue: 0.09605474025, alpha: 0.5088827055)
        gv.endColor = .clear
        return gv
    }()
    
    private lazy var viewContainer: UIView = {
        let tc = UIView()
        tc.backgroundColor = .clear
        return tc
    }()
    
    private lazy var titleLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .bold,
                                 size: 25,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var subtitleLabel: UILabel = {
        return Factory.makeLabel(title: nil,
                                 weight: .lightItalic,
                                 size: 14,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, subtitleLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var stackContainerView: UIStackView = {
        return strategy.arrangedSubviews()
    }()
    
    private lazy var headerImageBottomGradient: GradientView = {
        let gv = GradientView()
        gv.startColor = .clear
        gv.endColor = #colorLiteral(red: 0.2738285363, green: 0.2782334089, blue: 0.2810879052, alpha: 0.3487264556)
        return gv
    }()
    
    //MARK: -- Properties
    
    var currentSpecies: Species!
    
    var strategy: LearnMoreStrategy!
    
    private var previousStatusBarHidden = false
    
    private var animator: UIViewPropertyAnimator!
    
    
    //MARK: -- Methods
    
    @objc private func backButtonPressed() {
        animator?.stopAnimation(true)
        animator?.finishAnimation(at: .current)
        dismiss(animated: true, completion: nil)
    }
    
    private func configureUI() {
        FirebaseStorageService.learnMoreOverviewImageManager.getImage(for: currentSpecies.commonName, setTo: headerImageView)
        FirebaseStorageService.detailImageManager.getImage(for: currentSpecies.commonName, setTo: backgroundImageView)
        titleLabel.text = currentSpecies.commonName
        subtitleLabel.text = currentSpecies.taxonomy.scientificName
    }
    
    private func setupHeaderVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: { [weak self] in
            guard let self = self else { return }
            self.headerVisualEffectBlur.effect = nil
        })
        animator.pausesOnCompletion = true
        animator.isReversed = true
        animator.fractionComplete = 0
    }
    
    private func updateBackButtonAlpha(scrollOffset: CGFloat) {
        var newAlpha = CGFloat()
        newAlpha = scrollOffset < 100 ? 1 : 0
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: { [weak self] in
                            guard let self = self else { return }
                            self.backButton.alpha = newAlpha
                },
                           completion: nil)
        }
    }
    
    private func updateHeaderAnimator(with offset: CGFloat) {
        if offset > 0 {
            animator.fractionComplete = 0
            return
        }
        animator.fractionComplete = abs(offset) / 100
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        setupHeaderVisualEffectBlur()
        configureUI()
    }
}


//MARK: -- ScrollView Delegate Methods
extension LearnMoreViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateStatusBarVisibility()
        let contentOffsetY = scrollView.contentOffset.y
        updateBackButtonAlpha(scrollOffset: contentOffsetY)
        updateHeaderAnimator(with: contentOffsetY)
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension LearnMoreViewController {
    func addSubviews() {
        backgroundBlurEffectView.contentView.addSubview(scrollView)
        view.addSubview(backgroundBlurEffectView)
        view.addSubview(backButton)
        
        let UIElements = [imageContainer, headerImageView, viewContainer]
        UIElements.forEach { scrollView.addSubview($0) }
        
        let headerViewUIElements = [headerStatusBarGradient, headerVisualEffectBlur, headerImageBottomGradient, headerStackView]
        headerViewUIElements.forEach { headerImageView.addSubview($0) }
        
        viewContainer.addSubview(stackContainerView)
    }
    
    func setConstraints() {
        setBackgroundImageConstraints()
        setBackButtonConstraints()
        setScrollViewConstraints()
        
        setImageContainerConstraints()
        setHeaderImageViewConstraints()
        setHeaderVisualEffectBlurConstraints()
        setHeaderStatusBarGradientConstraints()
        setHeaderBottomGradientConstraints()
        setHeaderStackViewConstraints()
        
        setViewContainerConstraints()
        setContainerStackConstraints()
    }
    
    func setBackgroundImageConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func setBackButtonConstraints() {
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view).inset(50)
            make.leading.equalTo(view).inset(20)
            make.height.equalTo(backButton.frame.height)
            make.width.equalTo(backButton.frame.width)
        }
    }
    
    func setScrollViewConstraints() {
        scrollView.snp.makeConstraints {
            make in
            
            make.edges.equalTo(view)
        }
    }
    
    func setImageContainerConstraints() {
        imageContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.height.equalTo(imageContainer.snp.width).multipliedBy(0.7)
        }
    }
    
    func setHeaderImageViewConstraints() {
        headerImageView.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(imageContainer)
            make.top.equalTo(view).priority(.high)
            make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            make.bottom.equalTo(imageContainer.snp.bottom)
        }
    }
    
    func setHeaderStatusBarGradientConstraints() {
        headerStatusBarGradient.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(headerImageView)
            make.height.equalTo(headerImageView.snp.height).multipliedBy(0.25)
        }
    }
    
    func setHeaderVisualEffectBlurConstraints() {
        headerVisualEffectBlur.snp.makeConstraints { (make) in
            make.edges.equalTo(headerImageView)
        }
    }
    
    func setHeaderStackViewConstraints() {
        headerStackView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalTo(headerImageView).inset(20)
        }
    }
    
    func setHeaderBottomGradientConstraints() {
        headerImageBottomGradient.snp.makeConstraints {(make) in
            make.leading.top.bottom.trailing.equalTo(headerImageView)
        }
    }
    
    
    func setViewContainerConstraints() {
        viewContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(imageContainer.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(scrollView)
        }
    }
    
    
    func setContainerStackConstraints() {
        stackContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(viewContainer).inset(14)
        }
    }
}


//MARK: -- Statusbar

extension LearnMoreViewController {
    
    private var shouldHideStatusBar: Bool {
        let frame = viewContainer.convert(viewContainer.bounds, to: nil)
        return frame.minY < view.safeAreaInsets.top
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func updateStatusBarVisibility() {
        if previousStatusBarHidden != shouldHideStatusBar {
            
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self = self else { return }
                self.setNeedsStatusBarAppearanceUpdate()
            })
            
            previousStatusBarHidden = shouldHideStatusBar
        }
    }
}

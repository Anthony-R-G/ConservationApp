//
//  CLONESpeciesDetailViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/13/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseUI

final class AlternateSpeciesDetailViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    private lazy var verticalScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.delegate = self
        return sv
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.translatesAutoresizingMaskIntoConstraints = false
        gv.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.0)
        gv.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.8456228596)
        
        view.insertSubview(gv, at: 1)
        return gv
    }()
    
    private lazy var headerNameView: DetailHeaderNameView = {
        let hiv = DetailHeaderNameView()
        var frame = hiv.frame
        frame.size.height = 275
        hiv.frame = frame
        return hiv
    }()
    
    private lazy var subheaderInfoView: DetailSubheaderView = {
        let siv = DetailSubheaderView()
        var frame = siv.frame
        frame.size.height = 80
        siv.frame = frame
        return siv
    }()
    
    private lazy var backgroundVisualEffectBlur: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    }()
    
    private lazy var exploreButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        btn.isUserInteractionEnabled = false
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.setTitle("Explore", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Light", size: 16)
        btn.alignImageAndTitleVertically()
        btn.imageView?.transform = CGAffineTransform(scaleX: 1.2, y: 1)
        
        let color = UIColor(white: 1, alpha: 0.6)
        btn.setTitleColor(color, for: .normal)
        btn.tintColor = color
        return btn
    }()
    
    private lazy var donateButton: DonateButton = {
        return DonateButton(gradientColors: [#colorLiteral(red: 1, green: 0.2914688587, blue: 0.3886995912, alpha: 0.9019156678), #colorLiteral(red: 0.5421239734, green: 0.1666001081, blue: 0.2197911441, alpha: 0.8952536387)],
                            startPoint: CGPoint(x: 0, y: 0),
                            endPoint: CGPoint(x: 1, y: 1))
    }()
    
    private lazy var overviewButton: UIButton = {
        let btn = UIButton()
        btn.tag = 0
        btn.setTitle("OVERVIEW", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 45)
        btn.setTitleColor(.white, for: .normal)
        btn.showsTouchWhenHighlighted = true
        btn.addTarget(self, action: #selector(optionButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var habitatButton: UIButton = {
        let btn = UIButton()
        btn.tag = 1
        btn.setTitle("HABITAT", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 45)
        btn.setTitleColor(.white, for: .normal)
        btn.showsTouchWhenHighlighted = true
        btn.addTarget(self, action: #selector(optionButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var threatsButton: UIButton = {
        let btn = UIButton()
        btn.tag = 2
        btn.setTitle("THREATS", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 45)
        btn.setTitleColor(.white, for: .normal)
        btn.showsTouchWhenHighlighted = true
        btn.addTarget(self, action: #selector(optionButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var fillerButton: UIButton = {
        let btn = UIButton()
        btn.isUserInteractionEnabled = true
        btn.setTitle("FILLER", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 45)
        btn.setTitleColor(.white, for: .normal)
        
        return btn
    }()
    
    private lazy var moreFillerButton: UIButton = {
        let btn = UIButton()
        btn.isUserInteractionEnabled = true
        btn.setTitle("FILLER", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 45)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private lazy var optionsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            overviewButton, habitatButton, threatsButton, fillerButton, moreFillerButton
        ])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fillEqually
        sv.alpha = 0
        return sv
    }()
    
    private lazy var headerNameViewHeightConstraint: NSLayoutConstraint = {
        return headerNameView.heightAnchor.constraint(equalToConstant: headerNameView.frame.height)
    }()
    
    private lazy var headerNameViewTopAnchorConstraint: NSLayoutConstraint = {
        return headerNameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400)
    }()
    
    private lazy var subheaderInfoViewHeightConstraint: NSLayoutConstraint = {
        return subheaderInfoView.heightAnchor.constraint(equalToConstant: subheaderInfoView.frame.height)
    }()
    
    
    //MARK: -- Properties
    
    var currentSpecies: Species!
    
    var headerPinnedToTop: Bool = false {
        didSet {
            headerPinnedToTop ? animateStackIn() : animateStackOut()
        }
    }
    
    private var animator: UIViewPropertyAnimator!
    
    //MARK: -- Methods
    
    @objc private func optionButtonPressed(sender: UIButton) {
        let learnMoreVC = LearnMoreViewController()
        learnMoreVC.currentSpecies = currentSpecies
        switch sender.tag {
        case 0:
            learnMoreVC.strategy = LearnMoreVCOverviewStrategy(species: currentSpecies)
            
        case 1:
            learnMoreVC.strategy = LearnMoreVCHabitatStrategy(species: currentSpecies)
            
        case 2:
            learnMoreVC.strategy = LearnMoreVCThreatsStrategy(species: currentSpecies)
            
        default: ()
        }
        
        learnMoreVC.modalPresentationStyle = .fullScreen
        present(learnMoreVC, animated: true, completion: nil)
    }
    
    private func setViewElementsFromSpeciesData() {
        headerNameView.configureView(from: currentSpecies)
        subheaderInfoView.configureView(from: currentSpecies)
    }
    
    private func setupBackgroundVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: { [weak self] in
            guard let self = self else { return }
            self.backgroundVisualEffectBlur.effect = nil
        })
        animator.pausesOnCompletion = true
        animator.isReversed = true
        animator.fractionComplete = 0
    }
    
    private func updateBackgroundAnimator(with offset: CGFloat) {
        if offset <= 0 {
            animator.fractionComplete = 0
            return
        }
        animator.fractionComplete = abs(offset)/1000
    }
    
    private func setBackground() {
        view.backgroundColor = .black
        FirebaseStorageService.detailImageManager.getImage(for: currentSpecies.commonName, setTo: backgroundImageView)
    }
    
    private func animateStackIn() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.5) {
                [weak self] in guard let self = self else { return }
                self.optionsStack.alpha = 1
            }
        }
    }
    
    private func animateStackOut() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                [weak self] in guard let self = self else { return }
                self.optionsStack.alpha = 0
            }
        }
    }
    
    private func presentWebBrowser(link: URL){
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        let safariVC = SFSafariViewController(url: link, configuration: config)
        present(safariVC, animated: true)
    }
    
    private func updateTopGradientAlpha(scrollOffset: CGFloat) {
        let alphaOffset = (scrollOffset/400)
        let newAlpha = max(0, min(alphaOffset, 0.38))
        backgroundGradientOverlay.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: Float(newAlpha))
    }
    
    private func updateExploreLabelAlpha(scrollOffset: CGFloat) {
        var newAlpha = CGFloat()
        newAlpha = scrollOffset <= 40 ? 0.6 : 0
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: { [weak self] in
                            guard let self = self else { return }
                            self.exploreButton.alpha = newAlpha
                },
                           completion: nil)
        }
    }
    
    private func updateHeaderViewHeight(scrollOffset: CGFloat) {
        let headerNameViewOffset = 275 - (scrollOffset)
        let newHeaderNameViewHeight = max(110, headerNameViewOffset)
        headerNameViewHeightConstraint.constant = newHeaderNameViewHeight
    }
    
    private func updateHeaderTopAnchor(scrollOffset: CGFloat) {
        let headerTopAnchorConstantOffset = 400 - scrollOffset
        let newHeaderTopAnchorConstant = max(35, headerTopAnchorConstantOffset)
        headerNameViewTopAnchorConstraint.constant = newHeaderTopAnchorConstant
    }
    
    private func updateSubheaderHeight(scrollOffset: CGFloat) {
        let subheaderViewOffset = 80 - (scrollOffset)
        let newSubheaderViewHeight = max(50, subheaderViewOffset)
        subheaderInfoViewHeightConstraint.constant = newSubheaderViewHeight
    }
    
    private func checkHeaderLock() {
        if headerNameViewTopAnchorConstraint.constant == 35 {
            headerPinnedToTop = true
        } else {
            headerPinnedToTop = false
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setVerticalScrollViewConstraints()
        verticalScrollView.contentSize.height = UIScreen.main.bounds.height + 400
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        exploreButton.startShimmeringAnimation(animationSpeed: 2,
                                               direction: .leftToRight,
                                               repeatCount: .infinity)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        animator?.stopAnimation(true)
        animator?.finishAnimation(at: .current)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        setupBackgroundVisualEffectBlur()
        setViewElementsFromSpeciesData()
        setBackground()
    }
}

//MARK: -- ScrollView Methods
extension AlternateSpeciesDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case verticalScrollView:
            let offsetY = scrollView.contentOffset.y
            updateBackgroundAnimator(with: offsetY)
            updateTopGradientAlpha(scrollOffset: offsetY)
            updateExploreLabelAlpha(scrollOffset: offsetY)
            updateHeaderViewHeight(scrollOffset: offsetY)
            updateHeaderTopAnchor(scrollOffset: offsetY)
            updateSubheaderHeight(scrollOffset: offsetY)
            checkHeaderLock()
            
            
        default:()
        }
    }
}

//MARK: -- Custom Delegate Implementation
extension AlternateSpeciesDetailViewController: DonateButtonDelegate {
    func donateButtonPressed() {
        guard let donationURL = URL(string: currentSpecies.donationLink) else { return }
        presentWebBrowser(link: donationURL)
    }
}


//MARK: -- Add Subviews & Constraints
fileprivate extension AlternateSpeciesDetailViewController {
    func addSubviews() {
        view.addSubview(verticalScrollView)
        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalScrollViewUIElements = [headerNameView, subheaderInfoView, exploreButton, optionsStack]
        verticalScrollViewUIElements.forEach{ verticalScrollView.addSubview($0) }
        verticalScrollViewUIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        backgroundImageView.addSubview(backgroundVisualEffectBlur)
    }
    
    func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setHeaderInfoViewConstraints()
        setSubheaderInfoViewConstraints()
        setDiscoverButtonConstraints()
        
        setOptionsStackConstraints()
        setHeaderVisualEffectBlurConstraints()
    }
    
    func setVerticalScrollViewConstraints() {
        verticalScrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    func setBackgroundImageViewConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setBackgroundGradientOverlayConstraints() {
        backgroundGradientOverlay.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setHeaderVisualEffectBlurConstraints() {
        backgroundVisualEffectBlur.snp.makeConstraints { (make) in
            make.edges.equalTo(backgroundImageView)
        }
    }
    
    func setHeaderInfoViewConstraints() {
        NSLayoutConstraint.activate([
            headerNameView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor, constant: Constants.spacingConstant),
            headerNameView.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor),
            headerNameViewTopAnchorConstraint,
            headerNameViewHeightConstraint
        ])
    }
    
    func setSubheaderInfoViewConstraints() {
        NSLayoutConstraint.activate([
            subheaderInfoView.leadingAnchor.constraint(equalTo: headerNameView.leadingAnchor),
            subheaderInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subheaderInfoView.topAnchor.constraint(equalTo: headerNameView.bottomAnchor, constant: Constants.spacingConstant),
            subheaderInfoViewHeightConstraint
        ])
    }
    
    func setDiscoverButtonConstraints() {
        NSLayoutConstraint.activate([
            exploreButton.heightAnchor.constraint(equalToConstant: exploreButton.frame.size.height),
            exploreButton.widthAnchor.constraint(equalToConstant: exploreButton.frame.size.width),
            exploreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exploreButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    func setOptionsStackConstraints() {
        NSLayoutConstraint.activate([
            optionsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            optionsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170)
        ])
    }
}

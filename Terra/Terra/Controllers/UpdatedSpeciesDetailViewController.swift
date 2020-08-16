//
//  UpdatedSpeciesDetailViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/15/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseUI

final class UpdatedSpeciesDetailViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    private lazy var verticalScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.0)
        gv.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.8456228596)
        view.insertSubview(gv, at: 1)
        return gv
    }()
    
    private lazy var headerNameView: DetailHeaderNameView = {
        let hiv = DetailHeaderNameView()
        var frame = hiv.frame
        frame.size.height = UIScreen.main.bounds.height * 0.30
        hiv.frame = frame
        return hiv
    }()
    
    private lazy var subheaderInfoView: DetailSubheaderView = {
        let siv = DetailSubheaderView()
        var frame = siv.frame
        frame.size.height = headerNameView.frame.height * 0.30
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
        let btn = DonateButton(gradientColors: [#colorLiteral(red: 1, green: 0.2914688587, blue: 0.3886995912, alpha: 0.9019156678), #colorLiteral(red: 0.5421239734, green: 0.1666001081, blue: 0.2197911441, alpha: 0.8952536387)],
                               startPoint: CGPoint(x: 0, y: 0),
                               endPoint: CGPoint(x: 1, y: 1))
        btn.alpha = 0
        btn.delegate = self
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let screen = UIScreen.main.bounds
    
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screen.width * 0.833,
                                 height: screen.height * 0.445)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: Constants.spacingConstant,
                                           left: Constants.spacingConstant,
                                           bottom: Constants.spacingConstant,
                                           right: Constants.spacingConstant)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.alpha = 0
        cv.dataSource = self
        cv.delegate = self
        cv.register(RoundedInfoCell.self, forCellWithReuseIdentifier: "cellId")
        return cv
    }()
    
    
    //MARK: -- Properties
    private var strategies: [LearnMoreVCStrategy]!
    
    var currentSpecies: Species!
    
    var headerPinnedToTop: Bool = false {
        didSet {
            headerPinnedToTop ? animateCollectionViewIn() : animateCollectionViewOut()
        }
    }
    
    private var selectedCell: UICollectionViewCell?
    
    private var animator: UIViewPropertyAnimator!
    
    private lazy var headerNameViewHeightConstraint: NSLayoutConstraint = {
        return headerNameView.heightAnchor.constraint(equalToConstant: headerNameView.frame.height)
    }()
    
    private lazy var headerNameViewTopAnchorConstraint: NSLayoutConstraint = {
        return headerNameView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.48)
    }()
    
    private lazy var subheaderInfoViewHeightConstraint: NSLayoutConstraint = {
        return subheaderInfoView.heightAnchor.constraint(equalToConstant: subheaderInfoView.frame.height)
    }()
    
    private lazy var closeButton: UIButton = {
           let btn = UIButton()
           btn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
           btn.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
           btn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.845703125)
           btn.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
           return btn
       }()
    
    //MARK: -- Methods
    
    @objc private func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
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
    
    private func animateCollectionViewIn() {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0) {
                [weak self] in guard let self = self else { return }
                self.collectionView.alpha = 1
                self.donateButton.alpha = 1
            }
        }
    }
    
    private func animateCollectionViewOut() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                [weak self] in guard let self = self else { return }
                self.collectionView.alpha = 0
                self.donateButton.alpha = 0
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
        let screenHeight = UIScreen.main.bounds.height
        let headerNameViewOffset = (screenHeight * 0.30) - (scrollOffset)
        let newHeaderNameViewHeight = max(screenHeight * 0.123, headerNameViewOffset)
        headerNameViewHeightConstraint.constant = newHeaderNameViewHeight
    }
    
    private func updateHeaderTopAnchor(scrollOffset: CGFloat) {
        let screenHeight = UIScreen.main.bounds.height
        let headerTopAnchorConstantOffset = (screenHeight * 0.48) - scrollOffset
        let newHeaderTopAnchorConstant = max(screenHeight * 0.10, headerTopAnchorConstantOffset)
        headerNameViewTopAnchorConstraint.constant = newHeaderTopAnchorConstant
    }
    
    private func updateSubheaderHeight(scrollOffset: CGFloat) {
        let subheaderViewOffset = (headerNameView.frame.height * 0.30) - (scrollOffset)
        let newSubheaderViewHeight = max(50, subheaderViewOffset)
        subheaderInfoViewHeightConstraint.constant = newSubheaderViewHeight
    }
    
    private func checkHeaderLock() {
        if headerNameViewTopAnchorConstraint.constant == UIScreen.main.bounds.height * 0.10 {
            headerPinnedToTop = true
        } else {
            headerPinnedToTop = false
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setVerticalScrollViewConstraints()
        verticalScrollView.contentSize.height = UIScreen.main.bounds.height + 400
        verticalScrollView.delegate = self
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
        navigationController?.navigationBar.isHidden = true
        addSubviews()
        setConstraints()
        setupBackgroundVisualEffectBlur()
        setBackground()
        setViewElementsFromSpeciesData()
        
        strategies = [LearnMoreVCOverviewStrategy(species: currentSpecies), LearnMoreVCHabitatStrategy(species: currentSpecies), LearnMoreVCThreatsStrategy(species: currentSpecies)]
        
    }
}

//MARK: -- ScrollView Methods
extension UpdatedSpeciesDetailViewController: UIScrollViewDelegate {
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

//MARK: -- Collection View Data Source
extension UpdatedSpeciesDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! RoundedInfoCell
        let specificStrategy = strategies[indexPath.row]
        cell.strategy = specificStrategy
        return cell
    }
}

//MARK: -- Collection View Delegate
extension UpdatedSpeciesDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath)
        let learnMoreVC = UpdatedLearnMoreViewController()
        let specificStrategy = strategies[indexPath.row]
        learnMoreVC.strategy = specificStrategy
        navigationController?.pushViewController(learnMoreVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

//MARK: -- Custom Delegate Implementation

extension UpdatedSpeciesDetailViewController: DonateButtonDelegate {
    func donateButtonPressed() {
        guard let donationURL = URL(string: currentSpecies.donationLink) else { return }
        presentWebBrowser(link: donationURL)
    }
}


//MARK: -- Add Subviews & Constraints

fileprivate extension UpdatedSpeciesDetailViewController {
    func addSubviews() {
        view.addSubview(verticalScrollView)
        
        let UIElements = [headerNameView, subheaderInfoView, exploreButton]
        UIElements.forEach{ verticalScrollView.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        backgroundImageView.addSubview(backgroundVisualEffectBlur)
        
        view.addSubview(collectionView)
        view.addSubview(donateButton)
        view.addSubview(closeButton)
    }
    
    func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setHeaderInfoViewConstraints()
        setSubheaderInfoViewConstraints()
        setDiscoverButtonConstraints()
        
        setBackgroundVisualEffectBlurConstraints()
        setCollectionViewConstraints()
        setDonateButtonConstraints()
        setCloseButtonConstraints()
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
    
    func setBackgroundVisualEffectBlurConstraints() {
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
    
    func setCollectionViewConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(450)
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().offset(70)
        }
    }
    
    func setDonateButtonConstraints() {
        donateButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).inset(70)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            make.width.equalTo(375)
        }
    }
    
    func setCloseButtonConstraints() {
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.width.equalTo(66)
        }
    }
}

extension UpdatedSpeciesDetailViewController: Animatable {
    var containerView: UIView? {
        return collectionView
    }
    
    var childView: UIView? {
        return selectedCell
    }
}

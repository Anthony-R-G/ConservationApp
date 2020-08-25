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

final class SpeciesCoverViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        view.insertSubview(iv, at: 0)
        iv.backgroundColor = .black
        FirebaseStorageService.coverImageManager.getImage(
            for: viewModel.selectedSpecies.commonName,
            setTo: iv)
        return iv
    }()
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.0)
        gv.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.8456228596)
        view.insertSubview(gv, at: 1)
        return gv
    }()
    
    private lazy var headerNameView: CoverHeaderNameView = {
        let hiv = CoverHeaderNameView()
        var frame = hiv.frame
        frame.size.height = headerNameViewEnlargedHeight
        hiv.frame = frame
        hiv.configureView(from: viewModel.selectedSpecies)
        hiv.delegate = self
        return hiv
    }()
    
    private lazy var subheaderInfoView: CoverSubheaderInfoView = {
        let siv = CoverSubheaderInfoView()
        var frame = siv.frame
        frame.size.height = subheaderInfoViewEnlargedHeight
        siv.frame = frame
        siv.configureView(from: viewModel.selectedSpecies)
        return siv
    }()
    
    private lazy var backgroundVisualEffectBlur: UIVisualEffectView = {
        return UIVisualEffectView(effect: nil)
    }()
    
    private lazy var exploreButton: UIButton = {
        let btn = UIButton(frame: CGRect(
            origin: .zero,
            size: CGSize(width: 80.deviceAdjusted, height: 80.deviceAdjusted)))
        
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.setTitle("Explore", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto-Light", size: 16)
        btn.alignImageAndTitleVertically()
        btn.imageView?.transform = CGAffineTransform(scaleX: 1.2,
                                                     y: 1)
        btn.addTarget(
            self,
            action: #selector(handlePageStateSwipeGesture),
            for: .touchUpInside)
        
        let color = UIColor(white: 1, alpha: 0.6)
        btn.setTitleColor(color, for: .normal)
        btn.tintColor = color
        return btn
    }()
    
    private lazy var upButton: UIButton = {
        let btn = UIButton(frame: CGRect(
            origin: .zero,
            size: CGSize(width: 80.deviceAdjusted, height: 80.deviceAdjusted)))
        
        btn.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        
        btn.imageView?.transform = CGAffineTransform(scaleX: 1.2, y: 1)
        btn.addTarget(
            self,
            action: #selector(handlePageStateSwipeGesture),
            for: .touchUpInside)
        
        btn.tintColor = .white
        btn.alpha = 0
        return btn
    }()
    
    //To set donate button equally between view & cv bottom
    private lazy var donateButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var donateButton: DonateButton = {
        let btn = DonateButton(gradientColors: [#colorLiteral(red: 1, green: 0.2914688587, blue: 0.3886995912, alpha: 0.9019156678), #colorLiteral(red: 0.5421239734, green: 0.1666001081, blue: 0.2197911441, alpha: 0.8952536387)],
                               startPoint: CGPoint(x: 0,
                                                   y: 0),
                               endPoint: CGPoint(x: 1,
                                                 y: 1))
        btn.alpha = 0
        btn.delegate = self
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionViewFrame = CGRect(
            origin: .zero,
            size: CGSize(
                width: Constants.screenWidth,
                height: Constants.screenHeight * 0.468))
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: 345.deviceAdjusted,
            height:  collectionViewFrame.height * 0.89)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30.deviceAdjusted
        layout.sectionInset = UIEdgeInsets(
            top: Constants.spacingConstant / 2,
            left: Constants.spacingConstant,
            bottom: Constants.spacingConstant / 2,
            right: Constants.spacingConstant)
        
        let cv = UICollectionView(
            frame: collectionViewFrame,
            collectionViewLayout: layout)
        
        cv.backgroundColor = .clear
        cv.alpha = 0
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(CoverRoundedCell.self,
                    forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        btn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        btn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.845703125)
        btn.addTarget(
            self,
            action: #selector(closeButtonPressed),
            for: .touchUpInside)
        return btn
    }()
    
    private lazy var pageStateSwipeGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handlePageStateSwipeGesture))
        recognizer.direction = .up
        return recognizer
    }()
    
    private lazy var dismissPageSwipeGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handlePageStateSwipeGesture))
        recognizer.direction = .down
        return recognizer
    }()
    
    private lazy var augmentedRealityButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arkit"), for: .normal)
        btn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        btn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.845703125)
        btn.addTarget(
            self,
            action: #selector(augmentedRealityButtonPressed),
            for: .touchUpInside)
        return btn
    }()
    
    //MARK: -- Properties
    
    var viewModel: DetailPageStrategyViewModel!
    
    fileprivate let reuseIdentifier = "cellId"
    
    private var pageState: State = .collapsed
    
    private var selectedCell: UICollectionViewCell?
    
    private var headerNameViewEnlargedHeight: CGFloat = Constants.screenHeight * 0.30
    
    private var headerNameViewShrinkHeight: CGFloat = Constants.screenHeight * 0.11
    
    private var headerNameViewEnlargedTopAnchor: CGFloat = Constants.screenHeight * 0.48
    
    private var headerNameViewShrinkTopAnchor: CGFloat = Constants.screenHeight * 0.130
    
    private lazy var subheaderInfoViewEnlargedHeight: CGFloat = headerNameViewEnlargedHeight * 0.30
    
    private lazy var subheaderInfoViewShrinkHeight: CGFloat = 60.deviceAdjusted
    
    private lazy var headerNameViewHeightConstraint: NSLayoutConstraint = {
        return headerNameView.heightAnchor.constraint(equalToConstant: headerNameView.frame.height)
    }()
    
    private lazy var headerNameViewTopAnchorConstraint: NSLayoutConstraint = {
        return headerNameView.topAnchor.constraint(
            equalTo: view.topAnchor, constant: headerNameViewEnlargedTopAnchor)
    }()
    
    private lazy var subheaderInfoViewHeightConstraint: NSLayoutConstraint = {
        return subheaderInfoView.heightAnchor.constraint(
            equalToConstant: subheaderInfoView.frame.height)
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: -- Methods
    
    @objc private func augmentedRealityButtonPressed() {
        print("now cool stuff happens")
    }
    
    @objc private func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handlePageStateSwipeGesture() {
        animatePageState()
    }
    
    @objc private func handleDismissSwipeGesture() {
        dismiss(animated: true, completion: nil)
    }
    
    private func presentWebBrowser(link: URL){
        let config = SFSafariViewController.Configuration()
        let safariVC = SFSafariViewController(url: link,
                                              configuration: config)
        present(safariVC, animated: true)
    }
    
    private func addGestureRecognizers() {
        view.addGestureRecognizer(pageStateSwipeGesture)
        view.addGestureRecognizer(dismissPageSwipeGesture)
    }
    
    
    //MARK: -- Life Cycle Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        exploreButton.startShimmeringAnimation(animationSpeed: 2,
                                               direction: .leftToRight,
                                               repeatCount: .infinity)
        upButton.startShimmeringAnimation(animationSpeed: 2,
                                          direction: .leftToRight,
                                          repeatCount: .infinity)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        addGestureRecognizers()
    }
}

//MARK: -- Animatable
extension SpeciesCoverViewController: Animatable {
    var containerView: UIView? {
        return collectionView
    }
    
    var childView: UIView? {
        return selectedCell
    }
}

//MARK: -- State Animations

extension SpeciesCoverViewController {
    
    private func animatePageState() {
        let state = pageState.opposite
        let animator = UIViewPropertyAnimator(duration: 1.3,
                                              dampingRatio: 0.75,
                                              animations: { [weak self] in
            guard let self = self else { return }
            switch state {
            case .expanded:
                self.dismissPageSwipeGesture.isEnabled = false
                self.backgroundVisualEffectBlur.effect = UIBlurEffect(style: .regular)
                self.shrinkHeader()
                self.animateExploreButton(state: state)
                self.animateMainContent(state: state)
                
                
            case .collapsed:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    guard let self = self else { return }
                    self.dismissPageSwipeGesture.isEnabled = true
                }
                self.backgroundVisualEffectBlur.effect = nil
                self.enlargeHeader()
                self.animateExploreButton(state: state)
                self.animateMainContent(state: state)
                
            }
            self.view.layoutIfNeeded()
        })
        
        animator.addCompletion { [weak self ] (position) in
            guard let self = self else { return }
            switch position {
            case .start:
                self.pageState = state.opposite
            case .end:
                self.pageStateSwipeGesture.direction = self.pageStateSwipeGesture.direction.opposite
                self.pageState = state
            case .current:
                ()
            @unknown default:
                ()
            }
        }
        animator.startAnimation()
    }
    
    private func shrinkHeader() {
        headerNameView.shrinkCommonNameLabel()
        headerNameViewTopAnchorConstraint.constant = headerNameViewShrinkHeight
        headerNameViewHeightConstraint.constant = headerNameViewShrinkTopAnchor
        subheaderInfoViewHeightConstraint.constant = subheaderInfoViewShrinkHeight
    }
    
    private func enlargeHeader() {
        headerNameView.expandCommonNameLabel()
        headerNameViewTopAnchorConstraint.constant = headerNameViewEnlargedTopAnchor
        headerNameViewHeightConstraint.constant = headerNameViewEnlargedHeight
        subheaderInfoViewHeightConstraint.constant = subheaderInfoViewEnlargedHeight
    }
    
    private func animateExploreButton(state: State) {
        let newExploreButtonAlpha: CGFloat = state == .expanded ? 0.0 : 0.6
        let newUpButtonAlpha: CGFloat = state == .expanded ? 0.6 : 0.0
        let duration: TimeInterval = state == .expanded ? 0.4 : 2.0
        let upDuration: TimeInterval = state == .expanded ? 2.0 : 0.4
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration) { [ weak self] in
                guard let self = self else { return }
                self.exploreButton.alpha = newExploreButtonAlpha
                self.augmentedRealityButton.alpha = newExploreButtonAlpha
            }
            UIView.animate(withDuration: upDuration) { [weak self] in
                guard let self = self else { return }
                self.upButton.alpha = newUpButtonAlpha
            }
        }
    }
    
    private func animateMainContent(state: State) {
        let newAlpha: CGFloat = state == .expanded ? 1.0 : 0.0
        let duration: TimeInterval = state == .expanded ? 0.9 : 0.3
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration) { [weak self] in
                guard let self = self else { return }
                self.collectionView.alpha = newAlpha
                self.donateButton.alpha = newAlpha
            }
        }
    }
}


//MARK: -- Collection View Data Source

extension SpeciesCoverViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalStrategiesCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as! CoverRoundedCell
        
        let specificStrategy = viewModel.specificStrategy(at: indexPath.row)
        cell.strategy = specificStrategy
        return cell
    }
}

//MARK: -- Collection View Delegate

extension SpeciesCoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath)
        var strategy = viewModel.specificStrategy(at: indexPath.row)
        let detailVC = strategy.getDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

//MARK: -- Custom Delegate Implementation

extension SpeciesCoverViewController: DonateButtonDelegate {
    func donateButtonPressed() {
        guard let donationURL = URL(string: viewModel.selectedSpecies.donationLink) else { return }
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        presentWebBrowser(link: donationURL)
    }
}

extension SpeciesCoverViewController: ConservationStatusDelegate {
    func conservationStatusTapped() {
        presentWebBrowser(link: URL(string: "https://www.sanbi.org/skep/the-iucn-red-list-explained/")!)
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesCoverViewController {
    func addSubviews() {
        [collectionView, headerNameView, subheaderInfoView, donateButtonContainer, closeButton, augmentedRealityButton, exploreButton, upButton].forEach { view.addSubview($0) }
        backgroundImageView.addSubview(backgroundVisualEffectBlur)
        donateButtonContainer.addSubview(donateButton)
    }
    
    func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundVisualEffectBlurConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setCloseButtonConstraints()
        setARButtonConstraints()
        
        setHeaderInfoViewConstraints()
        setSubheaderInfoViewConstraints()
        setExploreButtonConstraints()
        setUpButtonConstraints()
        
        setCollectionViewConstraints()
        setDonateButtonContainerConstraints()
        setDonateButtonConstraints()
    }
    
    func setBackgroundImageViewConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setBackgroundVisualEffectBlurConstraints() {
        backgroundVisualEffectBlur.snp.makeConstraints { (make) in
            make.edges.equalTo(backgroundImageView)
        }
    }
    
    func setBackgroundGradientOverlayConstraints() {
        backgroundGradientOverlay.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setCloseButtonConstraints() {
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.width.equalTo(66.deviceAdjusted)
        }
    }
    
    func setARButtonConstraints() {
        augmentedRealityButton.snp.makeConstraints { (make) in
            make.top.equalTo(closeButton)
            make.leading.equalToSuperview().inset(5)
            make.height.width.equalTo(66.deviceAdjusted)
        }
    }
    
    func setHeaderInfoViewConstraints() {
        headerNameView.snp.makeConstraints { (make) in
            make.leading.equalTo(view).inset(Constants.spacingConstant)
            make.trailing.equalTo(view)
            headerNameViewTopAnchorConstraint.isActive = true
            headerNameViewHeightConstraint.isActive = true
        }
    }
    
    func setSubheaderInfoViewConstraints() {
        subheaderInfoView.snp.makeConstraints { (make) in
            make.leading.equalTo(headerNameView)
            make.trailing.equalTo(view)
            make.top.equalTo(headerNameView.snp.bottom).offset(Constants.spacingConstant)
            subheaderInfoViewHeightConstraint.isActive = true
        }
    }
    
    func setExploreButtonConstraints() {
        exploreButton.snp.makeConstraints { (make) in
            make.height.equalTo(exploreButton.frame.height)
            make.width.equalTo(exploreButton.frame.width)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).inset(10.deviceAdjusted)
        }
    }
    
    func setUpButtonConstraints() {
        upButton.snp.makeConstraints { (make) in
            make.height.equalTo(upButton.frame.height)
            make.width.equalTo(upButton.frame.width)
            make.centerX.equalTo(view)
            make.top.equalTo(view).inset(Constants.spacingConstant)
        }
    }
    
    func setCollectionViewConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(collectionView.frame.height)
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().offset(70.deviceAdjusted)
        }
    }
    
    func setDonateButtonContainerConstraints() {
        donateButtonContainer.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).inset(Constants.spacingConstant)
        }
    }
    
    func setDonateButtonConstraints() {
        donateButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(donateButtonContainer)
            make.leading.trailing.equalToSuperview().inset(Constants.spacingConstant)
            make.height.equalTo(50.deviceAdjusted)
        }
    }
}

private enum State {
    case expanded
    case collapsed
}

extension State {
    var opposite: State {
        switch self {
        case .collapsed: return .expanded
        case .expanded: return .collapsed
        }
    }
}




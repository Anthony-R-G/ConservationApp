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
    
    private lazy var scrollView: UIScrollView = {
        return UIScrollView()
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        FirebaseStorageService.coverImageManager.getImage(
            for: viewModel.species.commonName,
            setTo: iv)
        return iv
    }()
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.0)
        gv.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.8456228596)
        return gv
    }()
    
    private lazy var headerNameView: CoverHeaderNameView = {
        return CoverHeaderNameView(species: viewModel.species, delegate: self)
    }()
    
    private lazy var subheaderInfoView: CoverSubheaderInfoView = {
        return CoverSubheaderInfoView(species: viewModel.species)
    }()
    
    private lazy var backgroundVisualEffectBlur: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blur.alpha = 0
        return blur
    }()
    
    private lazy var downChevron: UIButton = {
        let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 30.deviceScaled, height: 15.deviceScaled)))
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.addTarget(self, action: #selector(togglePageState), for: .touchUpInside)
        btn.tintColor = .white
        btn.alpha = 0.6
        return btn
    }()
    
    private lazy var upChevron: UIButton = {
        let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 30.deviceScaled, height: 15.deviceScaled)))
        btn.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.addTarget(self, action: #selector(togglePageState), for: .touchUpInside)
        btn.tintColor = .white
        btn.alpha = 0
        return btn
    }()
    
    
    //Sets chevron centerY between view bottom & subheader
    private lazy var downChevronContainer: UIView = {
        return UIView()
    }()
    
    private lazy var donateButton: DonateButton = {
        let btn = DonateButton(
            gradientColors: [#colorLiteral(red: 1, green: 0.2914688587, blue: 0.3886995912, alpha: 1), #colorLiteral(red: 0.3837335624, green: 0.1666001081, blue: 0.1801935414, alpha: 1)],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1))
        btn.alpha = 0
        btn.delegate = self
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
         
        let collectionViewFrame = CGRect(
            origin: .zero,
            size: CGSize(
                width: Constants.screenWidth,
                height: Constants.screenHeight * 0.31))
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: 315.deviceScaled,
            height:  collectionViewFrame.height * 0.99)
        
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(
            frame: collectionViewFrame,
            collectionViewLayout: layout)
        
        cv.backgroundColor = .clear
        cv.alpha = 0
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(CoverRoundedCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        return cv
    }()
    
    private lazy var closeButton: CircleBlurButton = {
        let btn = Factory.makeBlurredCircleButton(image: .close, style: .light, size: .regular)
        btn.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
        return btn
    }()
    
    private lazy var augmentedRealityButton: UIButton = {
        let btn = Factory.makeBlurredCircleButton(image: .augmentedReality, style: .light, size: .regular)
        btn.addTarget(self, action: #selector(augmentedRealityButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var pageStateSwipeGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(togglePageState))
        recognizer.direction = .up
        return recognizer
    }()
    
    private lazy var dismissPageSwipeGesture: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissPage))
        recognizer.direction = .down
        return recognizer
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            DetailInfoWindow(title: "DESCRIPTION",
                             content: Factory.makeDetailInfoWindowLabel(text: viewModel.species.overview)),
            
            collectionView,
            
            DetailInfoWindow(title: "CLASSIFICATION",
                             content: ClassificationView(species: viewModel.species)),
            
            DetailInfoWindow(title: "MEASUREMENTS", content: MeasurementsView(species: viewModel.species)),
            
            DetailInfoWindow(title: "AVERAGE LIFESPAN", content: Factory.makeDetailInfoWindowLabel(text: "\(viewModel.species.averageLifespan) in the wild"))
            
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.padding
        stackView.distribution = .equalSpacing
        stackView.alpha = 0
        return stackView
    }()
    
    
    //MARK: -- Properties
    
    private var viewModel: DetailPageStrategyViewModel
    
    private var pageState: State = .collapsed
    
    private var selectedCell: UICollectionViewCell?
    
    private let headerNameViewEnlargedHeight: CGFloat = Constants.screenHeight * 0.30
    
    private let headerNameViewShrinkHeight: CGFloat = Constants.screenHeight * 0.10
    
    private let headerNameViewEnlargedTopAnchor: CGFloat = Constants.screenHeight * 0.48
    
    private let headerNameViewShrinkTopAnchor: CGFloat = Constants.screenHeight * 0.135
    
    private lazy var subheaderInfoViewEnlargedHeight: CGFloat = headerNameViewEnlargedHeight * 0.30
    
    private let subheaderInfoViewShrinkHeight: CGFloat = 60.deviceScaled
    
    private lazy var headerNameViewHeightConstraint: NSLayoutConstraint = {
        return headerNameView.heightAnchor.constraint(equalToConstant: headerNameViewEnlargedHeight)
    }()
    
    private lazy var headerNameViewTopAnchorConstraint: NSLayoutConstraint = {
        return headerNameView.topAnchor.constraint(equalTo: view.topAnchor, constant: headerNameViewEnlargedTopAnchor)
    }()
    
    private lazy var subheaderInfoViewHeightConstraint: NSLayoutConstraint = {
        return subheaderInfoView.heightAnchor.constraint(equalToConstant: subheaderInfoViewEnlargedHeight)
    }()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    //MARK: -- Methods
    
    @objc private func augmentedRealityButtonPressed() {
        print("now cool stuff happens")
    }
    
    @objc private func dismissPage() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func togglePageState() {
        animatePageStateTransition()
    }
    
    private func addGestureRecognizers() {
        view.addGestureRecognizer(pageStateSwipeGesture)
        view.addGestureRecognizer(dismissPageSwipeGesture)
    }
    
    private func startShimmerAnimationOnViews() {
        [downChevron, upChevron].forEach { $0.startShimmeringAnimation(
            animationSpeed: 2,
            direction: .leftToRight,
            repeatCount: .infinity) }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: view.safeAreaInsets.bottom + 40,
                                               right: 0)
    }
    
    //MARK: -- Life Cycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startShimmerAnimationOnViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        addGestureRecognizers()
    }
    
    init(viewModel: DetailPageStrategyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func animatePageStateTransition() {
        let state = pageState.opposite
        let animator = UIViewPropertyAnimator(
            duration: 1.3,
            dampingRatio: 0.75,
            animations: { [weak self] in guard let self = self else { return }
                switch state {
                case .expanded:
                    self.dismissPageSwipeGesture.isEnabled = false
                    self.resizeHeader(state: state)
                    self.downChevronContainer.isUserInteractionEnabled = false
                    self.animateDetailInfoOptionsVisibility(state: state)
                    self.animateButtonControlsVisibility(state: state)
                    
                case .collapsed:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                        guard let self = self else { return }
                        self.dismissPageSwipeGesture.isEnabled = true
                    }
                    self.resizeHeader(state: state)
                    self.downChevronContainer.isUserInteractionEnabled = true
                    self.animateButtonControlsVisibility(state: state)
                    self.animateDetailInfoOptionsVisibility(state: state)
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
    
    private func resizeHeader(state: State) {
        switch state {
        case .expanded:
            headerNameView.shrinkCommonNameLabel()
            headerNameViewTopAnchorConstraint.constant = headerNameViewShrinkHeight
            headerNameViewHeightConstraint.constant = headerNameViewShrinkTopAnchor
            subheaderInfoViewHeightConstraint.constant = subheaderInfoViewShrinkHeight
            
        case .collapsed:
            headerNameView.enlargeCommonNameLabel()
            headerNameViewTopAnchorConstraint.constant = headerNameViewEnlargedTopAnchor
            headerNameViewHeightConstraint.constant = headerNameViewEnlargedHeight
            subheaderInfoViewHeightConstraint.constant = subheaderInfoViewEnlargedHeight
        }
    }
    
    
    private func animateButtonControlsVisibility(state: State) {
        let newDownChevronAlpha: CGFloat = state == .expanded ? 0.0 : 0.6
        let newUpChevronAlpha: CGFloat = state == .expanded ? 0.6 : 0.0
        let newARButtonAlpha: CGFloat = state == .expanded ? 0.0 : 1.0
        
        let downChevronDuration: TimeInterval = state == .expanded ? 0.4 : 2.0
        let upChevronDuration: TimeInterval = state == .expanded ? 2.0 : 0.4
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: downChevronDuration) { [ weak self] in
                guard let self = self else { return }
                self.downChevron.alpha = newDownChevronAlpha
                self.augmentedRealityButton.alpha = newARButtonAlpha
            }
            UIView.animate(withDuration: upChevronDuration) { [weak self] in
                guard let self = self else { return }
                self.upChevron.alpha = newUpChevronAlpha
            }
        }
    }
    
    private func animateDetailInfoOptionsVisibility(state: State) {
        let newAlpha: CGFloat = state == .expanded ? 1.0 : 0.0
        let reverseAlpha: CGFloat = state == .expanded ? 0.0 : 1.0
        let duration: TimeInterval = state == .expanded ? 0.9 : 0.3
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration) { [weak self] in
                guard let self = self else { return }
                self.stackView.alpha = newAlpha
                self.collectionView.alpha = newAlpha
                self.donateButton.alpha = newAlpha
                self.backgroundVisualEffectBlur.alpha = newAlpha
                self.backgroundGradientOverlay.alpha = reverseAlpha
            }
        }
    }
}


//MARK: -- Collection View Data Source

extension SpeciesCoverViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.detailPageStrategies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellReuseIdentifier,
            for: indexPath) as? CoverRoundedCell else { return UICollectionViewCell() }
        
        let specificStrategy = viewModel.specificStrategy(at: indexPath.row)
        cell.strategy = specificStrategy
        return cell
    }
}

//MARK: -- Collection View Delegate

extension SpeciesCoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCell = collectionView.cellForItem(at: indexPath)
        var strategy = viewModel.specificStrategy(at: indexPath.row)
        let detailVC = strategy.getDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        selectedCell = collectionView.cellForItem(at: indexPath)
        Utilities.sendHapticFeedback(action: .itemSelected)
        UIView.animate(withDuration: 0.3) { [weak self] in guard let self = self else { return }
            self.selectedCell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
        selectedCell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3) { [weak self] in guard let self = self else { return }
            self.selectedCell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

//MARK: -- Custom Delegate Implementation

extension SpeciesCoverViewController: DonateButtonDelegate {
    func donateButtonPressed() {
        guard let donationURL = URL(string: viewModel.species.donationLink) else { return }
        Utilities.sendHapticFeedback(action: .itemSelected)
        Utilities.presentWebBrowser(on: self, link: donationURL, delegate: nil)
    }
}

extension SpeciesCoverViewController: ConservationStatusDelegate {
    func conservationStatusTapped() {
        Utilities.presentWebBrowser(on: self, link: URL(string: "https://www.sanbi.org/skep/the-iucn-red-list-explained/")!, delegate: nil)
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesCoverViewController {
    func addSubviews() {
        [backgroundImageView, backgroundGradientOverlay, subheaderInfoView, downChevronContainer, upChevron, headerNameView, scrollView, augmentedRealityButton, closeButton, donateButton]
            .forEach { view.addSubview($0) }
        
        scrollView.addSubview(stackView)
        
        backgroundImageView.addSubview(backgroundVisualEffectBlur)
        
        downChevronContainer.addSubview(downChevron)
    }
    
    func setConstraints() {
        
        setBackgroundImageViewConstraints()
        setBackgroundVisualEffectBlurConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setCloseButtonConstraints()
        setARButtonConstraints()
        
        setHeaderInfoViewConstraints()
        setSubheaderInfoViewConstraints()
        
        setScrollViewConstraints()
        setContainerStackView()
        
        setDownChevronContainerConstraints()
        setDownChevronConstraints()
        setUpChevronConstraints()
        
        setCollectionViewConstraints()
        setDonateButtonConstraints()
        
    }
    
    func setScrollViewConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(subheaderInfoView.snp.bottom).offset(Constants.padding)
        }
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
            make.top.trailing.equalToSuperview().inset(Constants.padding)
        }
    }
    
    func setARButtonConstraints() {
        augmentedRealityButton.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(Constants.padding)
        }
    }
    
    func setHeaderInfoViewConstraints() {
        headerNameView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(Constants.padding)
            make.trailing.equalToSuperview()
            headerNameViewTopAnchorConstraint.isActive = true
            headerNameViewHeightConstraint.isActive = true
        }
    }
    
    func setSubheaderInfoViewConstraints() {
        subheaderInfoView.snp.makeConstraints { (make) in
            make.leading.equalTo(headerNameView)
            make.trailing.equalToSuperview()
            make.top.equalTo(headerNameView.snp.bottom).offset(Constants.padding)
            subheaderInfoViewHeightConstraint.isActive = true
        }
    }
    
    func setDownChevronContainerConstraints() {
        downChevronContainer.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(subheaderInfoView.snp.bottom).inset(Constants.padding)
        }
    }
    
    func setDownChevronConstraints() {
        downChevron.snp.makeConstraints { (make) in
            make.height.width.equalTo(downChevron.frame.size)
            make.centerX.centerY.equalTo(downChevronContainer)
        }
    }
    
    func setUpChevronConstraints() {
        upChevron.snp.makeConstraints { (make) in
            make.height.width.equalTo(upChevron.frame.size)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.padding)
        }
    }
    
    func setCollectionViewConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(collectionView.frame.height)
        }
    }
    
    func setDonateButtonConstraints() {
        donateButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(Constants.padding)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50.deviceScaled)
        }
    }
    
    func setContainerStackView() {
        stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view).inset(Constants.padding)
            make.bottom.greaterThanOrEqualTo(scrollView)
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

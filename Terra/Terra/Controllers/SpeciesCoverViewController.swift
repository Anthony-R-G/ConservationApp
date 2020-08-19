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
        FirebaseStorageService.coverImageManager.getImage(for: selectedSpecies.commonName, setTo: iv)
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
        frame.size.height = screenSize.height * 0.30
        hiv.frame = frame
        hiv.configureView(from: selectedSpecies)
        return hiv
    }()
    
    private lazy var subheaderInfoView: CoverSubheaderInfoView = {
        let siv = CoverSubheaderInfoView()
        var frame = siv.frame
        frame.size.height = headerNameView.frame.height * 0.30
        siv.frame = frame
        siv.configureView(from: selectedSpecies)
        return siv
    }()
    
    private lazy var backgroundVisualEffectBlur: UIVisualEffectView = {
        return UIVisualEffectView(effect: nil)
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
    
    //To set donate button equally between view & cv bottom
    private lazy var donateButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
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
        
        let collectionViewFrame = CGRect(origin: .zero,
                                         size: CGSize(
                                            width: screenSize.width,
                                            height: screenSize.height * 0.468))
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.width * 0.833,
                                 height:  collectionViewFrame.height * 0.89)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: Constants.spacingConstant / 2,
                                           left: Constants.spacingConstant,
                                           bottom: Constants.spacingConstant / 2,
                                           right: Constants.spacingConstant)
        
        let cv = UICollectionView(frame: collectionViewFrame,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.alpha = 0
        cv.dataSource = self
        cv.delegate = self
        cv.register(CoverRoundedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        btn.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        btn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.845703125)
        btn.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    //MARK: -- Properties
    
    private lazy var swipeGestureRecognizer: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer()
        recognizer.direction = .up
        recognizer.addTarget(self, action: #selector(handleSwipe(recognizer:)))
        return recognizer
    }()
    
    private var strategies: [DetailPageStrategy]!
    
//    private var headerAnimator: UIViewPropertyAnimator!
    
    private var screenSize = UIScreen.main.bounds.size
    
    var selectedSpecies: Species!
    
    fileprivate let reuseIdentifier = "cellId"
    
    private var selectedCell: UICollectionViewCell?
    
    private lazy var headerNameViewHeightConstraint: NSLayoutConstraint = {
        return headerNameView.heightAnchor.constraint(equalToConstant: headerNameView.frame.height)
    }()
    
    private lazy var headerNameViewTopAnchorConstraint: NSLayoutConstraint = {
        return headerNameView.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height * 0.48)
    }()
    
    private lazy var subheaderInfoViewHeightConstraint: NSLayoutConstraint = {
        return subheaderInfoView.heightAnchor.constraint(equalToConstant: subheaderInfoView.frame.height)
    }()
    
    //MARK: -- Methods
    
    private var headerState: State = .collapsed
    
    @objc private func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func presentWebBrowser(link: URL){
        let config = SFSafariViewController.Configuration()
        let safariVC = SFSafariViewController(url: link, configuration: config)
        present(safariVC, animated: true)
    }
    
    
    //MARK: -- Life Cycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
//        setUpAnimator()
        exploreButton.startShimmeringAnimation(animationSpeed: 2,
                                               direction: .leftToRight,
                                               repeatCount: .infinity)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        backgroundVisualEffectBlur.effect = UIBlurEffect(style: .regular)
    }
    
    @objc func handleSwipe(recognizer: UITapGestureRecognizer) {
        setUpAnimator()
    }
    
    private func collapseHeader() {
        headerNameView.speciesCommonNameLabel.animateToFont(UIFont(name: "Roboto-Bold", size: 40)!, withDuration: 0.5)
        headerNameViewTopAnchorConstraint.constant = screenSize.height * 0.10
        headerNameViewHeightConstraint.constant = screenSize.height * 0.123
        subheaderInfoViewHeightConstraint.constant = 50
    }
    
    private func expandHeader() {
        headerNameView.speciesCommonNameLabel.animateToFont(UIFont(name: "Roboto-Bold", size: 56)!, withDuration: 0.5)
        headerNameViewTopAnchorConstraint.constant = screenSize.height * 0.48
        headerNameViewHeightConstraint.constant = screenSize.height * 0.30
        subheaderInfoViewHeightConstraint.constant = (screenSize.height * 0.30) * 0.30
    }
    
    private func setUpAnimator() {
        let state = headerState.opposite
        let headerAnimator = UIViewPropertyAnimator(duration: 1.3, dampingRatio: 0.7, animations: {
            switch state {
            case .expanded:
                print("Collapsing now")
                self.backgroundVisualEffectBlur.effect = UIBlurEffect(style: .regular)
                self.collapseHeader()
                self.animateCollectionViewIn()
                
            case .collapsed:
                print("Expanding now")
                self.backgroundVisualEffectBlur.effect = nil
                self.expandHeader()
                self.animateCollectionViewOut()
            }
            self.view.layoutIfNeeded()
        })
        
        headerAnimator.addCompletion { (position) in
            switch position {
            case .start:
                self.headerState = state.opposite
            case .end:
                self.swipeGestureRecognizer.direction = self.swipeGestureRecognizer.direction.opposite
                self.headerState = state
            case .current:
                ()
            @unknown default:
                ()
            }
        }
        headerAnimator.startAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black
        strategies = [DetailOverviewStrategy(species: selectedSpecies),
                      DetailHabitatStrategy(species: selectedSpecies),
                      DetailThreatsStrategy(species: selectedSpecies)]
        addSubviews()
        setConstraints()
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
}


//MARK: -- ScrollView Updates

extension SpeciesCoverViewController {
    
    
 
    
    private func animateCollectionViewIn() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.9) {
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
}


//MARK: -- Collection View Data Source

extension SpeciesCoverViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return strategies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CoverRoundedCell
        let specificStrategy = strategies[indexPath.row]
        cell.strategy = specificStrategy
        return cell
    }
}

//MARK: -- Collection View Delegate

extension SpeciesCoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath)
        let detailInfoVC = SpeciesDetailInfoViewController()
        let specificStrategy = strategies[indexPath.row]
        detailInfoVC.strategy = specificStrategy
        navigationController?.pushViewController(detailInfoVC, animated: true)
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

//MARK: -- DonateButton Delegate Implementation

extension SpeciesCoverViewController: DonateButtonDelegate {
    func donateButtonPressed() {
        guard let donationURL = URL(string: selectedSpecies.donationLink) else { return }
        presentWebBrowser(link: donationURL)
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesCoverViewController {
    func addSubviews() {
        [collectionView, donateButtonContainer, closeButton, exploreButton].forEach { view.addSubview($0) }
        
        [headerNameView, subheaderInfoView].forEach { view.addSubview($0) }
        
        backgroundImageView.addSubview(backgroundVisualEffectBlur)
        donateButtonContainer.addSubview(donateButton)
    }
    
    func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundVisualEffectBlurConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setCloseButtonConstraints()
        setHeaderInfoViewConstraints()
        setSubheaderInfoViewConstraints()
        setExploreButtonConstraints()
        
        
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
            make.height.width.equalTo(66)
        }
    }
    
    func setHeaderInfoViewConstraints() {
        headerNameView.snp.makeConstraints { (make) in
            make.leading.equalTo(view).inset(Constants.spacingConstant)
            make.width.equalTo(view).inset(30)
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
            make.bottom.equalTo(view).inset(10)
        }
    }
    
    func setCollectionViewConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(collectionView.frame.height)
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().offset(70)
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
            make.width.equalTo(view).multipliedBy(0.9)
            make.height.equalTo(50)
        }
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



extension UILabel {
    func copyLabel() -> UILabel {
        let label = UILabel()
        label.font = self.font
        label.frame = self.frame
        label.text = self.text
        return label
    }
}

extension UILabel {
    func animateToFont(_ font: UIFont, withDuration duration: TimeInterval) {
        let oldFont = self.font
        self.font = font
        let oldOrigin = frame.origin
        let labelScale = oldFont!.pointSize / font.pointSize
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        let newOrigin = frame.origin
        frame.origin = oldOrigin
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            self.frame.origin = newOrigin
            self.transform = oldTransform
            self.layoutIfNeeded()
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

extension UISwipeGestureRecognizer.Direction {
    var opposite: UISwipeGestureRecognizer.Direction {
        switch self {
        case .up: return .down
        case .down: return .up
        default:
            ()
        }
        return self.opposite
    }
}

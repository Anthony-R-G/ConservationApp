//
//  SpeciesDetailViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/17/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseUI

final class SpeciesDetailViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    private lazy var verticalScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private lazy var horizontalScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        sv.showsHorizontalScrollIndicator = false
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
    
    private lazy var headerNameView: HeaderNameView = {
        let hiv = HeaderNameView()
        var frame = hiv.frame
        frame.size.height = 275
        hiv.frame = frame
        return hiv
    }()
    
    private lazy var subheaderInfoView: SubheaderInfoView = {
        let siv = SubheaderInfoView()
        var frame = siv.frame
        frame.size.height = 80
        siv.frame = frame
        return siv
    }()
    
    private lazy var exploreButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        btn.isUserInteractionEnabled = false
        btn.setImage(UIImage(systemName: "chevron.up"), for: .normal)
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
        return DonateButton(gradientColors: [#colorLiteral(red: 1, green: 0.2914688587, blue: 0.3886995912, alpha: 0.9019156678), #colorLiteral(red: 0.5421239734, green: 0.1666001081, blue: 0.2197911441, alpha: 0.8952536387)], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
    }()
    
    private lazy var bottomToolBar: toolBar = {
        return toolBar(frame: .zero, strategy: ToolBarDetailVCStrategy())
    }()
    
    private lazy var speciesOverviewView: RoundedInfoView = {
        return Factory.makeRoundedInfoView(strategy: SpeciesOverviewStrategy(species: currentSpecies))
    }()
    
    private lazy var speciesHabitatView: RoundedInfoView = {
        return Factory.makeRoundedInfoView(strategy: SpeciesHabitatStrategy(species: currentSpecies))
    }()
    
    private lazy var speciesThreatsView: RoundedInfoView = {
        return Factory.makeRoundedInfoView(strategy: SpeciesThreatsStrategy(species: currentSpecies))
    }()
    
    private lazy var speciesGalleryView: RoundedInfoView = {
        return Factory.makeRoundedInfoView(strategy: SpeciesGalleryStrategy(species: currentSpecies))
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
    
    private lazy var horizontalScrollViewTopAnchorConstraint: NSLayoutConstraint = {
        return horizontalScrollView.topAnchor.constraint(equalTo: headerNameView.bottomAnchor, constant: 280)
    }()
    
    //MARK: -- Properties
    
    var currentSpecies: Species!
    
    
    //MARK: -- Methods
    
    private func setViewElementsFromSpeciesData() {
        headerNameView.setViewElementsFromSpeciesData(species: currentSpecies)
        subheaderInfoView.setViewElementsFromSpeciesData(species: currentSpecies)
    }
    
    private func setBackground() {
        view.backgroundColor = .black
        FirebaseStorageService.detailImageManager.getImage(for: currentSpecies.commonName, setTo: backgroundImageView)
    }
    
    private func setDelegates() {
        [verticalScrollView, horizontalScrollView].forEach { $0.delegate = self }
        bottomToolBar.delegate = self
        donateButton.delegate = self
        [speciesOverviewView, speciesHabitatView, speciesThreatsView, speciesGalleryView].forEach {$0.delegate = self }
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
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.exploreButton.alpha = newAlpha
            }, completion: nil)
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
    
    private func updateHorizontalScrollTopAnchor(scrollOffset: CGFloat) {
        let horizontalScrollTopAnchorOffset = 300 - scrollOffset
        let newHorizontalScrollTopAnchorConstant = max(90, horizontalScrollTopAnchorOffset)
        horizontalScrollViewTopAnchorConstraint.constant = newHorizontalScrollTopAnchorConstant
    }
    
    private func transitionToView(buttonPressed: ButtonOption) {
        switch buttonPressed {
            
        case .buttonOne:
            horizontalScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
        case .buttonTwo:
            horizontalScrollView.setContentOffset(CGPoint(x: speciesHabitatView.frame.minX - Constants.universalLeadingConstant, y: 0), animated: true)
            
        case .buttonThree:
            horizontalScrollView.setContentOffset(CGPoint(x: speciesThreatsView.frame.minX - Constants.universalLeadingConstant, y: 0), animated: true)
            
        case .buttonFour:
            horizontalScrollView.setContentOffset(CGPoint(x: speciesGalleryView.frame.minX - Constants.universalLeadingConstant, y: 0), animated: true)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setVerticalScrollViewConstraints()
        setHorizontalScrollViewConstraints()
        
        //This is hardcoded for now. Need to adjust for diff device sizes in future without having extra scroll space.
        verticalScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 350)
        horizontalScrollView.contentSize = CGSize(width: view.frame.width + 1300, height: 300)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        exploreButton.startShimmeringAnimation(animationSpeed: 2, direction: .leftToRight, repeatCount: .infinity)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        setDelegates()
        
        setViewElementsFromSpeciesData()
        setBackground()
        bottomToolBar.highlightButton(button: .buttonOne)
    }
}

//MARK: -- ScrollView Methods
extension SpeciesDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case verticalScrollView:
            let offsetY = scrollView.contentOffset.y
            
            updateTopGradientAlpha(scrollOffset: offsetY)
            updateExploreLabelAlpha(scrollOffset: offsetY)
            updateHeaderViewHeight(scrollOffset: offsetY)
            updateHeaderTopAnchor(scrollOffset: offsetY)
            updateSubheaderHeight(scrollOffset: offsetY)
            updateHorizontalScrollTopAnchor(scrollOffset: offsetY)
            
        case horizontalScrollView:
            let offsetX = scrollView.contentOffset.x
            
            bottomToolBar.updateHighlightIndicator(scrollOffset: offsetX)
            
            if scrollView.bounds.contains(speciesOverviewView.frame) {
                bottomToolBar.highlightButton(button: .buttonOne)
                
            } else if scrollView.bounds.contains(speciesHabitatView.frame) {
                bottomToolBar.highlightButton(button: .buttonTwo)
                
            } else if scrollView.bounds.contains(speciesThreatsView.frame) {
                bottomToolBar.highlightButton(button: .buttonThree)
                
            } else if scrollView.bounds.contains(speciesGalleryView.frame) {
                bottomToolBar.highlightButton(button: .buttonFour)
                
            }
            
        default:()
        }
    }
}

//MARK: -- Custom Delegate Implementation
extension SpeciesDetailViewController: DonateButtonDelegate {
    func donateButtonPressed() {
        guard let donationURL = URL(string: currentSpecies.donationLink) else { return }
        presentWebBrowser(link: donationURL)
    }
}

extension SpeciesDetailViewController: BottomBarDelegate {
    func buttonPressed(_ sender: UIButton) {
        guard let buttonOption = ButtonOption(rawValue: sender.tag) else { return }
        bottomToolBar.highlightButton(button: buttonOption)
        transitionToView(buttonPressed: buttonOption)
    }
}

extension SpeciesDetailViewController: RoundedInfoViewDelegate {
    func learnMoreButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let mapVC = MapViewController()
            mapVC.currentSpecies = currentSpecies
            mapVC.modalPresentationStyle = .fullScreen
            present(mapVC, animated: true, completion: nil)
        default: print(sender.tag)
        }
    }
}


//MARK: -- Add Subviews & Constraints
fileprivate extension SpeciesDetailViewController {
    func addSubviews() {
        view.addSubview(verticalScrollView)
        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalScrollViewUIElements = [headerNameView, subheaderInfoView, exploreButton, horizontalScrollView, donateButton, bottomToolBar]
        verticalScrollViewUIElements.forEach{ verticalScrollView.addSubview($0) }
        verticalScrollViewUIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let horizontalScrollViewUIElements = [speciesOverviewView, speciesHabitatView, speciesThreatsView, speciesGalleryView]
        horizontalScrollViewUIElements.forEach{ horizontalScrollView.addSubview($0) }
        horizontalScrollViewUIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setHeaderInfoViewConstraints()
        setSubheaderInfoViewConstraints()
        setDiscoverButtonConstraints()
        
        setSpeciesOverviewViewConstraints()
        setSpeciesHabitatViewConstraints()
        setSpeciesThreatsViewConstraints()
        setSpeciesGalleryViewConstraints()
        
        setDonateButtonConstraints()
        setBottomToolBarConstraints()
    }
    
    func setVerticalScrollViewConstraints() {
        verticalScrollView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setHorizontalScrollViewConstraints() {
        horizontalScrollView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            horizontalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: Constants.roundedInfoViewHeight),
            horizontalScrollViewTopAnchorConstraint
        ])
    }
    
    func setBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    func setBackgroundGradientOverlayConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundGradientOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundGradientOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundGradientOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    func setHeaderInfoViewConstraints() {
        NSLayoutConstraint.activate([
            headerNameView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor, constant: Constants.universalLeadingConstant),
            headerNameView.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor),
            headerNameViewTopAnchorConstraint,
            headerNameViewHeightConstraint
        ])
    }
    
    func setSubheaderInfoViewConstraints() {
        NSLayoutConstraint.activate([
            subheaderInfoView.leadingAnchor.constraint(equalTo: headerNameView.leadingAnchor),
            subheaderInfoView.trailingAnchor.constraint(equalTo: headerNameView.trailingAnchor),
            subheaderInfoView.topAnchor.constraint(equalTo: headerNameView.bottomAnchor, constant: Constants.universalLeadingConstant),
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
    
    func setDonateButtonConstraints() {
        NSLayoutConstraint.activate([
            donateButton.widthAnchor.constraint(equalTo: speciesOverviewView.widthAnchor),
            donateButton.heightAnchor.constraint(equalToConstant: 50),
            donateButton.centerXAnchor.constraint(equalTo: bottomToolBar.centerXAnchor),
            donateButton.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 25)
        ])
    }
    
    func setBottomToolBarConstraints() {
        NSLayoutConstraint.activate([
            bottomToolBar.topAnchor.constraint(equalTo: donateButton.bottomAnchor, constant: 25),
            bottomToolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomToolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomToolBar.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setSpeciesOverviewViewConstraints() {
        NSLayoutConstraint.activate([
            speciesOverviewView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesOverviewView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor, constant: Constants.universalLeadingConstant),
            speciesOverviewView.widthAnchor.constraint(equalToConstant: Constants.roundedInfoViewWidth),
            speciesOverviewView.heightAnchor.constraint(equalToConstant: Constants.roundedInfoViewHeight),
        ])
    }
    
    func setSpeciesHabitatViewConstraints() {
        NSLayoutConstraint.activate([
            speciesHabitatView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesHabitatView.leadingAnchor.constraint(equalTo: speciesOverviewView.trailingAnchor, constant: Constants.universalLeadingConstant * 2),
            speciesHabitatView.widthAnchor.constraint(equalToConstant: Constants.roundedInfoViewWidth),
            speciesHabitatView.heightAnchor.constraint(equalToConstant: Constants.roundedInfoViewHeight),
        ])
    }
    
    func setSpeciesThreatsViewConstraints() {
        NSLayoutConstraint.activate([
            speciesThreatsView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesThreatsView.leadingAnchor.constraint(equalTo: speciesHabitatView.trailingAnchor, constant: Constants.universalLeadingConstant * 2),
            speciesThreatsView.widthAnchor.constraint(equalToConstant: Constants.roundedInfoViewWidth),
            speciesThreatsView.heightAnchor.constraint(equalToConstant: Constants.roundedInfoViewHeight),
        ])
    }
    
    func setSpeciesGalleryViewConstraints() {
        NSLayoutConstraint.activate([
            speciesGalleryView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesGalleryView.leadingAnchor.constraint(equalTo: speciesThreatsView.trailingAnchor, constant: Constants.universalLeadingConstant * 2),
            speciesGalleryView.widthAnchor.constraint(equalToConstant: Constants.roundedInfoViewWidth),
            speciesGalleryView.heightAnchor.constraint(equalToConstant: Constants.roundedInfoViewHeight),
        ])
    }
}




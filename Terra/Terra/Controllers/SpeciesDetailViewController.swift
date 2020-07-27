//
//  SpeciesDetailViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/17/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices

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
    
    private lazy var discoverLabel: UILabel = {
        let label = Utilities.makeLabel(title: "Discover", weight: .light, size: 25, alignment: .center)
        label.textColor = UIColor(white: 1, alpha: 0.7)
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var donateButton: DonateButton = {
        let db = DonateButton(gradientColors: [#colorLiteral(red: 1, green: 0.2914688587, blue: 0.3886995912, alpha: 0.9019156678), #colorLiteral(red: 0.5421239734, green: 0.1666001081, blue: 0.2197911441, alpha: 0.8952536387)], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        return db
    }()
    
    private lazy var bottomToolBar: BottomBarView = {
        return BottomBarView()
    }()
    
    private lazy var speciesOverviewView: SpeciesOverviewView = {
        return SpeciesOverviewView()
    }()
    
    private lazy var speciesThreatsView: SpeciesThreatsView = {
        return SpeciesThreatsView()
    }()
    
    private lazy var speciesHabitatView: SpeciesHabitatView = {
        return SpeciesHabitatView()
        
    }()
    
    private lazy var speciesGalleryView: SpeciesGalleryView = {
        return SpeciesGalleryView()
        
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
        return horizontalScrollView.topAnchor.constraint(equalTo: headerNameView.bottomAnchor, constant: 300)
    }()
    
    //MARK: -- Properties
    
    public var currentSpecies: Species!
    
    
    //MARK: -- Methods
    
    private func setViewElementsFromSpeciesData() {
        headerNameView.setViewElementsFromSpeciesData(species: currentSpecies)
        subheaderInfoView.setViewElementsFromSpeciesData(species: currentSpecies)
        speciesOverviewView.setViewElementsFromSpeciesData(species: currentSpecies)
        speciesThreatsView.setViewElementsFromSpeciesData(species: currentSpecies)
        speciesHabitatView.setViewElementsFromSpeciesData(species: currentSpecies)
    }
    
    private func setBackground() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        let imageURL = URL(string: currentSpecies!.detailImage)
        backgroundImageView.kf.setImage(with: imageURL)
    }
    
    private func setDelegates() {
        verticalScrollView.delegate = self
        horizontalScrollView.delegate = self
        bottomToolBar.actionDelegate = self
        donateButton.delegate = self
    }
    
    private func presentWebBrowser(link: URL){
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariVC = SFSafariViewController(url: link, configuration: config)
        present(safariVC, animated: true)
    }
    
    private func updateTopGradientAlpha(scrollOffset: CGFloat) {
        let alphaOffset = (scrollOffset/400)
        let newAlpha = max(0, min(alphaOffset, 0.34))
        backgroundGradientOverlay.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: Float(newAlpha))
    }
    
    private func updateDiscoverLabelAlpha(scrollOffset: CGFloat) {
        var newAlpha = CGFloat()
        if scrollOffset <= 40 {
            newAlpha = 0.7
        } else {
            newAlpha = 0
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.discoverLabel.alpha = newAlpha
                print(self.discoverLabel.alpha)
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
        let newHorizontalScrollTopAnchorConstant = max(100, horizontalScrollTopAnchorOffset)
        horizontalScrollViewTopAnchorConstraint.constant = newHorizontalScrollTopAnchorConstant
    }
    
    private func transitionToView(buttonPressed: ButtonOption) {
        switch buttonPressed {
            
        case .overviewButton:
            horizontalScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
        case .threatsButton:
            horizontalScrollView.setContentOffset(CGPoint(x: speciesThreatsView.frame.minX - 20, y: 0), animated: true)
            
        case .habitatButton:
            horizontalScrollView.setContentOffset(CGPoint(x: speciesHabitatView.frame.minX - 20, y: 0), animated: true)
            
        case .galleryButton:
            horizontalScrollView.setContentOffset(CGPoint(x: speciesGalleryView.frame.minX - 20, y: 0), animated: true)
        }
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
        discoverLabel.startShimmeringAnimation(animationSpeed: 2, direction: .leftToRight, repeatCount: .infinity)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        setDelegates()
        
        setViewElementsFromSpeciesData()
        setBackground()
        bottomToolBar.highlightButton(button: .overviewButton)
    }
}

//MARK: -- ScrollView Methods

extension SpeciesDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case verticalScrollView:
            let offsetY = scrollView.contentOffset.y
            
            updateTopGradientAlpha(scrollOffset: offsetY)
            updateDiscoverLabelAlpha(scrollOffset: offsetY)
            updateHeaderViewHeight(scrollOffset: offsetY)
            updateHeaderTopAnchor(scrollOffset: offsetY)
            updateSubheaderHeight(scrollOffset: offsetY)
            updateHorizontalScrollTopAnchor(scrollOffset: offsetY)
            
        case horizontalScrollView:
            let offsetX = scrollView.contentOffset.x
            
            bottomToolBar.updateHighlightIndicator(scrollOffset: offsetX)
            
            
            if scrollView.bounds.contains(speciesOverviewView.frame) {
                bottomToolBar.highlightButton(button: .overviewButton)
                
            } else if scrollView.bounds.contains(speciesThreatsView.frame) {
                bottomToolBar.highlightButton(button: .threatsButton)
                
            } else if scrollView.bounds.contains(speciesHabitatView.frame) {
                bottomToolBar.highlightButton(button: .habitatButton)
                
            } else if scrollView.bounds.contains(speciesGalleryView.frame) {
                bottomToolBar.highlightButton(button: .galleryButton)
                
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


//MARK: -- Adding Subviews & Constraints
extension SpeciesDetailViewController {
    private func addSubviews() {
        view.addSubview(verticalScrollView)
        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalScrollViewUIElements = [headerNameView, subheaderInfoView, discoverLabel, horizontalScrollView, donateButton, bottomToolBar]
        verticalScrollViewUIElements.forEach{ verticalScrollView.addSubview($0) }
        verticalScrollViewUIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let horizontalScrollViewUIElements = [speciesOverviewView, speciesThreatsView, speciesHabitatView, speciesGalleryView]
        horizontalScrollViewUIElements.forEach{ horizontalScrollView.addSubview($0) }
        horizontalScrollViewUIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setHeaderInfoViewConstraints()
        setSubheaderInfoViewConstraints()
        setDiscoverLabelConstraints()
        
        setSpeciesOverviewViewConstraints()
        setSpeciesThreatsViewConstraints()
        setSpeciesHabitatViewConstraints()
        setSpeciesGalleryViewConstraints()
        
        setDonateButtonConstraints()
        setBottomToolBarConstraints()
    }
    
    private func setVerticalScrollViewConstraints() {
        verticalScrollView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setHorizontalScrollViewConstraints() {
        horizontalScrollView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            horizontalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: Constants.detailInfoViewHeight),
            horizontalScrollViewTopAnchorConstraint
        ])
    }
    
    private func setBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    private func setBackgroundGradientOverlayConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundGradientOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundGradientOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundGradientOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    
    private func setHeaderInfoViewConstraints() {
        NSLayoutConstraint.activate([
            headerNameView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor, constant: 20),
            headerNameView.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor),
            headerNameViewTopAnchorConstraint,
            headerNameViewHeightConstraint
        ])
    }
    
    private func setSubheaderInfoViewConstraints() {
        NSLayoutConstraint.activate([
            subheaderInfoView.leadingAnchor.constraint(equalTo: headerNameView.leadingAnchor),
            subheaderInfoView.trailingAnchor.constraint(equalTo: headerNameView.trailingAnchor),
            subheaderInfoView.topAnchor.constraint(equalTo: headerNameView.bottomAnchor, constant: 20),
            subheaderInfoViewHeightConstraint
        ])
    }
    
    private func setDiscoverLabelConstraints() {
        NSLayoutConstraint.activate([
            discoverLabel.heightAnchor.constraint(equalToConstant: discoverLabel.frame.size.height),
            discoverLabel.widthAnchor.constraint(equalToConstant: discoverLabel.frame.size.width),
            discoverLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            discoverLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    private func setDonateButtonConstraints() {
        NSLayoutConstraint.activate([
            donateButton.widthAnchor.constraint(equalTo: speciesOverviewView.widthAnchor),
            donateButton.heightAnchor.constraint(equalToConstant: 50),
            donateButton.centerXAnchor.constraint(equalTo: bottomToolBar.centerXAnchor),
            donateButton.bottomAnchor.constraint(equalTo: bottomToolBar.topAnchor, constant: -30)
        ])
    }
    
    private func setBottomToolBarConstraints() {
        NSLayoutConstraint.activate([
            bottomToolBar.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 120),
            bottomToolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomToolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomToolBar.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setSpeciesOverviewViewConstraints() {
        NSLayoutConstraint.activate([
            speciesOverviewView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesOverviewView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor, constant: 20),
            speciesOverviewView.widthAnchor.constraint(equalToConstant: Constants.detailInfoViewWidth),
            speciesOverviewView.heightAnchor.constraint(equalToConstant: Constants.detailInfoViewHeight),
        ])
    }
    
    private func setSpeciesThreatsViewConstraints() {
        NSLayoutConstraint.activate([
            speciesThreatsView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesThreatsView.leadingAnchor.constraint(equalTo: speciesOverviewView.trailingAnchor, constant: 40),
            speciesThreatsView.widthAnchor.constraint(equalToConstant: Constants.detailInfoViewWidth),
            speciesThreatsView.heightAnchor.constraint(equalToConstant: Constants.detailInfoViewHeight),
        ])
    }
    
    private func setSpeciesHabitatViewConstraints() {
        NSLayoutConstraint.activate([
            speciesHabitatView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesHabitatView.leadingAnchor.constraint(equalTo: speciesThreatsView.trailingAnchor, constant: 40),
            speciesHabitatView.widthAnchor.constraint(equalToConstant: Constants.detailInfoViewWidth),
            speciesHabitatView.heightAnchor.constraint(equalToConstant: Constants.detailInfoViewHeight),
        ])
    }
    
    private func setSpeciesGalleryViewConstraints() {
        NSLayoutConstraint.activate([
            speciesGalleryView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesGalleryView.leadingAnchor.constraint(equalTo: speciesHabitatView.trailingAnchor, constant: 40),
            speciesGalleryView.widthAnchor.constraint(equalToConstant: Constants.detailInfoViewWidth),
            speciesGalleryView.heightAnchor.constraint(equalToConstant: Constants.detailInfoViewHeight),
        ])
    }
}

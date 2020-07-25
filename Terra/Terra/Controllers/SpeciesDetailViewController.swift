//
//  DetailViewController.swift
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
        return sv
    }()
    
    private lazy var horizontalScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
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
    
    private lazy var bottomToolBar: BottomBarView = {
        let bar = BottomBarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        return bar
    }()
    
    
    //    private lazy var donateButton: DonateButton = {
    //        let btn = DonateButton()
    //        var frame = btn.frame
    //        frame.size.width = 80
    //        frame.size.height = 80
    //        btn.frame = frame
    //        return btn
    //    }()
    
    private lazy var speciesOverviewView: SpeciesOverviewView = {
        let sov = SpeciesOverviewView()
        return sov
    }()
    
    private lazy var speciesThreatsView: SpeciesThreatsView = {
        let stv = SpeciesThreatsView()
        return stv
    }()
    
    private lazy var speciesHabitatView: SpeciesHabitatView = {
        let shv = SpeciesHabitatView()
        return shv
    }()
    
    private lazy var speciesGalleryView: SpeciesGalleryView = {
        let sgv = SpeciesGalleryView()
        return sgv
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
        let imageURL = URL(string: currentSpecies!.detailImage)
        backgroundImageView.kf.setImage(with: imageURL)
    }
    
    private func setDelegates() {
        verticalScrollView.delegate = self
        horizontalScrollView.delegate = self
        bottomToolBar.actionDelegate = self
        //        donateButton.delegate = self
        //        infoOptionPanelView.delegate = self
    }
    
    private func showWebBrowser(link: URL){
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariVC = SFSafariViewController(url: link, configuration: config)
        present(safariVC, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setVerticalScrollViewConstraints()
        setHorizontalScrollViewConstraints()
        
        //This is hardcoded for now. Need to adjust for diff device sizes in future without having extra scroll space.
        verticalScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 350)
        horizontalScrollView.contentSize = CGSize(width: view.frame.width + 1300, height: 300)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
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
            let offset = scrollView.contentOffset.y
            
            let alphaOffset = (offset/400)
            let alpha = max(0, min(alphaOffset, 0.34))
            backgroundGradientOverlay.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: Float(alpha))
            
            let hnvOffset = 275 - (offset)
            let hnvHeight = max(110, hnvOffset)
            headerNameViewHeightConstraint.constant = hnvHeight
            
            let headerTopAnchorConstantOffset = 400 - offset
            let headerTopAnchor = max(35, headerTopAnchorConstantOffset)
            headerNameViewTopAnchorConstraint.constant = headerTopAnchor
            
            let sivOffset = 80 - (offset)
            let sivHeight = max(50, sivOffset)
            subheaderInfoViewHeightConstraint.constant = sivHeight
            
            let overviewViewTopAnchorConstantOffset = 300 - offset
            let overviewViewTopAnchor = max(100, overviewViewTopAnchorConstantOffset)
            horizontalScrollViewTopAnchorConstraint.constant = overviewViewTopAnchor
            
        case horizontalScrollView:
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
        showWebBrowser(link: URL(string: currentSpecies.donationLink)!)
    }
}


extension SpeciesDetailViewController: BottomBarDelegate {
    func overviewButtonPressed(_ sender: UIButton) {
        bottomToolBar.highlightButton(button: .overviewButton)
        horizontalScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
    }
    
    func threatsButtonPressed(_ sender: UIButton) {
        bottomToolBar.highlightButton(button: .threatsButton)
        horizontalScrollView.setContentOffset(CGPoint(x: speciesThreatsView.frame.minX - 20, y: 0), animated: true)
    }
    
    func habitatButtonPressed(_ sender: UIButton) {
        bottomToolBar.highlightButton(button: .habitatButton)
        horizontalScrollView.setContentOffset(CGPoint(x: speciesHabitatView.frame.minX - 20, y: 0), animated: true)
    }
    
    
    func galleryButtonPressed(_ sender: UIButton) {
        bottomToolBar.highlightButton(button: .galleryButton)
        horizontalScrollView.setContentOffset(CGPoint(x: speciesGalleryView.frame.minX - 20, y: 0), animated: true)
        
    }
}

//MARK: -- Adding Subviews & Constraints
extension SpeciesDetailViewController {
    private func addSubviews() {
        view.addSubview(verticalScrollView)
        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalScrollViewUIElements = [headerNameView, subheaderInfoView, horizontalScrollView, bottomToolBar]
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
        setSpeciesOverviewViewConstraints()
        setSpeciesThreatsViewConstraints()
        setSpeciesHabitatViewConstraints()
        setSpeciesGalleryViewConstraints()
        setBottomToolBarConstraints()
        //        setDonateButtonConstraints()
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
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 420),
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
    
    private func setBottomToolBarConstraints() {
        NSLayoutConstraint.activate([
            bottomToolBar.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 110),
            bottomToolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomToolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomToolBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //
    //    private func setDonateButtonConstraints() {
    //        NSLayoutConstraint.activate([
    //            donateButton.widthAnchor.constraint(equalToConstant: donateButton.frame.width),
    //            donateButton.heightAnchor.constraint(equalToConstant: donateButton.frame.height),
    //            donateButton.centerXAnchor.constraint(equalTo: infoOptionPanelView.centerXAnchor),
    //            donateButton.bottomAnchor.constraint(equalTo: infoOptionPanelView.topAnchor, constant: 30)
    //        ])
    //    }
    
    private func setSpeciesOverviewViewConstraints() {
        NSLayoutConstraint.activate([
            speciesOverviewView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesOverviewView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor, constant: 20),
            speciesOverviewView.widthAnchor.constraint(equalToConstant: 375),
            speciesOverviewView.heightAnchor.constraint(equalToConstant: 420),
        ])
    }
    
    private func setSpeciesThreatsViewConstraints() {
        NSLayoutConstraint.activate([
            speciesThreatsView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesThreatsView.leadingAnchor.constraint(equalTo: speciesOverviewView.trailingAnchor, constant: 40),
            speciesThreatsView.widthAnchor.constraint(equalToConstant: 375),
            speciesThreatsView.heightAnchor.constraint(equalToConstant: 420),
        ])
    }
    
    private func setSpeciesHabitatViewConstraints() {
        NSLayoutConstraint.activate([
            speciesHabitatView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesHabitatView.leadingAnchor.constraint(equalTo: speciesThreatsView.trailingAnchor, constant: 40),
            speciesHabitatView.widthAnchor.constraint(equalToConstant: 375),
            speciesHabitatView.heightAnchor.constraint(equalToConstant: 420),
        ])
    }
    
    private func setSpeciesGalleryViewConstraints() {
        NSLayoutConstraint.activate([
            speciesGalleryView.centerYAnchor.constraint(equalTo: horizontalScrollView.centerYAnchor),
            speciesGalleryView.leadingAnchor.constraint(equalTo: speciesHabitatView.trailingAnchor, constant: 40),
            speciesGalleryView.widthAnchor.constraint(equalToConstant: 375),
            speciesGalleryView.heightAnchor.constraint(equalToConstant: 420),
        ])
    }
}

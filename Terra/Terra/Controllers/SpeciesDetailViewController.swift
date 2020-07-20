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
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.translatesAutoresizingMaskIntoConstraints = false
        gv.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.0)
        gv.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.8456228596)
        self.view.insertSubview(gv, at: 1)
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
    
//    private lazy var infoOptionPanelView: InfoOptionPanelView = {
//        let iopv = InfoOptionPanelView()
//        return iopv
//    }()
    
    private lazy var customTabBarPanel: CustomizedTabBar = {
        let ctb = CustomizedTabBar()
        ctb.layer.cornerRadius = 39
       return ctb
    }()
    
    private lazy var taxonomyView: TaxonomyView = {
        let tv = TaxonomyView()
        return tv
    }()
    
    private lazy var headerNameViewHeightConstraint: NSLayoutConstraint = {
        return headerNameView.heightAnchor.constraint(equalToConstant: headerNameView.frame.height)
    }()
    
    private lazy var headerNameViewTopAnchorConstraint: NSLayoutConstraint = {
        return headerNameView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 400)
    }()
    
    private lazy var subheaderInfoViewHeightConstraint: NSLayoutConstraint = {
        return subheaderInfoView.heightAnchor.constraint(equalToConstant: subheaderInfoView.frame.height)
    }()
    
    private lazy var taxonomyViewTopAnchorConstraint: NSLayoutConstraint = {
        return taxonomyView.topAnchor.constraint(equalTo: headerNameView.bottomAnchor, constant: 300)
    }()
    
    //MARK: -- Properties
    
    public var currentSpecies: Species!
    
    
    //MARK: -- Methods
    
    private func setViewElementsFromSpeciesData() {
        headerNameView.setViewElementsFromSpeciesData(species: currentSpecies)
        subheaderInfoView.setViewElementsFromSpeciesData(species: currentSpecies)
        taxonomyView.setViewElementsFromSpeciesData(species: currentSpecies)
    }
    
    private func setBackground() {
        let imageURL = URL(string: currentSpecies!.detailImage)
        backgroundImageView.kf.setImage(with: imageURL)
    }
    
    private func setDelegates() {
        scrollView.delegate = self
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
        setScrollViewConstraints()
        scrollView.updateContentView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        addSubviews()
        setConstraints()
        setDelegates()
        
        setViewElementsFromSpeciesData()
        setBackground()
    }
}

//MARK: -- ScrollView Methods

extension SpeciesDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        let alphaOffset = (offset/1200)
        let alpha = max(0, alphaOffset)
        backgroundGradientOverlay.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: Float(alpha))
        
        let y = 275 - (offset)
        let hnvHeight = max(110, y)
        headerNameViewHeightConstraint.constant = hnvHeight
        
        let headerTopAnchorConstantOffset = 400 - offset
        let headerTopAnchor = max(35, headerTopAnchorConstantOffset)
        headerNameViewTopAnchorConstraint.constant = headerTopAnchor
        
        let y2 = 80 - (offset)
        let sivHeight = max(50, y2)
        subheaderInfoViewHeightConstraint.constant = sivHeight
        
        let taxonomyViewTopAnchorConstantOffset = 300 - offset
        let taxonomyTopAnchor = max(100, taxonomyViewTopAnchorConstantOffset)
        taxonomyViewTopAnchorConstraint.constant = taxonomyTopAnchor
    }
}

//MARK: -- Custom Delegate Implementation
extension SpeciesDetailViewController: InfoOptionPanelDelegate {
    func donateButtonPressed() {
        showWebBrowser(link: URL(string: currentSpecies.donationLink)!)
    }
}

//MARK: -- Adding Subviews & Constraints
extension SpeciesDetailViewController {
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let UIElements = [headerNameView, subheaderInfoView, taxonomyView, customTabBarPanel]
        UIElements.forEach{ scrollView.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundGradientOverlayConstraints()
        setHeaderInfoViewConstraints()
        setSubheaderInfoViewConstraints()
        setTaxonomyViewConstraints()
//        setInfoOptionPanelViewConstraints()
        setCustomTabBarPanelViewConstraints()
    }
    
    private func setScrollViewConstraints() {
        scrollView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
            headerNameView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            headerNameView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
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
    
//    private func setInfoOptionPanelViewConstraints() {
//        NSLayoutConstraint.activate([
//            infoOptionPanelView.leadingAnchor.constraint(equalTo: taxonomyView.leadingAnchor),
//            infoOptionPanelView.trailingAnchor.constraint(equalTo: taxonomyView.trailingAnchor),
//            infoOptionPanelView.heightAnchor.constraint(equalToConstant: 70),
//            infoOptionPanelView.topAnchor.constraint(equalTo: taxonomyView.bottomAnchor, constant: 80)
//        ])
//    }
    
    private func setCustomTabBarPanelViewConstraints() {
          NSLayoutConstraint.activate([
              customTabBarPanel.leadingAnchor.constraint(equalTo: taxonomyView.leadingAnchor),
              customTabBarPanel.trailingAnchor.constraint(equalTo: taxonomyView.trailingAnchor),
              customTabBarPanel.heightAnchor.constraint(equalToConstant: 70),
              customTabBarPanel.topAnchor.constraint(equalTo: taxonomyView.bottomAnchor, constant: 100)
          ])
      }
    
    private func setTaxonomyViewConstraints() {
        NSLayoutConstraint.activate([
            taxonomyView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            taxonomyView.widthAnchor.constraint(equalToConstant: 375),
            taxonomyView.heightAnchor.constraint(equalToConstant: 420),
            taxonomyViewTopAnchorConstraint
        ])
    }
}

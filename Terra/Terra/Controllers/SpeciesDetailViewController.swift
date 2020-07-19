//
//  DetailViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/17/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
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
    
    
    private lazy var basicInfoView: BasicInfoView = {
        let biv = BasicInfoView()
        var frame = biv.frame
        frame.size.height = 275
        biv.frame = frame
        biv.backgroundColor = .black
        return biv
    }()
    
    private lazy var basicInfoViewHeightConstraint: NSLayoutConstraint = {
        return basicInfoView.heightAnchor.constraint(equalToConstant: basicInfoView.frame.height)
    }()
    
    private lazy var basicInfoViewTopAnchorConstraint: NSLayoutConstraint = {
        return basicInfoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 500)
    }()
    
    //MARK: -- Property Initialization
    public var currentSpecies: Species!
    
    var basicInfoViewisPinnedToTop = false
    
    private func setUIFromSpecies() {
        basicInfoView.setViewElementsFromSpeciesData(species: currentSpecies)
    }
    
    private func setBackground() {
        let imageURL = URL(string: currentSpecies!.detailImage)
        backgroundImageView.kf.setImage(with: imageURL)
    }
    
    private func setDelegates() {
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollViewConstraints()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 600)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        addSubviews()
        setConstraints()
        setDelegates()
        
        setUIFromSpecies()
        setBackground()
        
    }
}

//MARK: -- Extension to Add Subviews & Constraints
extension DetailViewController {
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(basicInfoView)
        basicInfoView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundGradientOverlayConstraints()
        setBasicInfoViewConstraints()
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
    
    private func setBackgroundGradientOverlayConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundGradientOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundGradientOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundGradientOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    private func setBasicInfoViewConstraints() {
        NSLayoutConstraint.activate([
            basicInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            basicInfoView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            basicInfoViewTopAnchorConstraint,
            basicInfoViewHeightConstraint
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
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        let y = 275 - (offset)
        let height = max(150, y)
        basicInfoViewHeightConstraint.constant = height
        
        
        let alphaOffset = (offset/1300)
        let alpha = max(0, alphaOffset)
        backgroundGradientOverlay.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: Float(alpha))
        
        let topAnchorConstant = 400 - offset
        let topAnchor = max(0, topAnchorConstant)
        basicInfoViewTopAnchorConstraint.constant = topAnchor
    }
}

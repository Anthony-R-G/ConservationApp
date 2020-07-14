//
//  ViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices

class SpeciesDetailViewController: UIViewController {
    
    var currentSpecies: Species!
    
    var scrollView = UIScrollView(frame: UIScreen.main.bounds)
    var contentView = UIView()
    
    var basicInfoView = BasicInfoView()
    var detailInfoOverlayView = DetailInfoOverlay()
    
    
    private func showWebBrowser(link: URL){
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariVC = SFSafariViewController(url: link, configuration: config)
        present(safariVC, animated: true)
    }
    
    //    private func eventLinkButtonPressed(_ sender: UIButton) {
    //         showWebBrowser(link: URL(string: currentSpecies.donationLink)!)
    //    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setViewsData(){
        basicInfoView.setUIFromSpecies(species: currentSpecies)
        detailInfoOverlayView.setUIFromSpecies(species: currentSpecies)
    }
    
    private func setBackground() {
        view.backgroundColor = .darkGray
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        let imageURL = URL(string: currentSpecies!.detailImage)
        backgroundImage.kf.setImage(with: imageURL)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let backgroundOverlay = GradientView(frame: UIScreen.main.bounds)
        backgroundOverlay.startColor = .clear
        backgroundOverlay.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.8456228596)
        self.view.insertSubview(backgroundOverlay, at: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewsData()
        setConstraints()
        setBackground()
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 600)
        
        basicInfoView.layer.zPosition = 0
        detailInfoOverlayView.layer.zPosition = 1
    }
}


//MARK: -- Constraints
extension SpeciesDetailViewController {
    private func setConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [basicInfoView, detailInfoOverlayView].forEach{ contentView.addSubview($0) }
        
        [basicInfoView, detailInfoOverlayView].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        setBasicInfoViewConstraints()
        setDetailInfoOverlayConstraints()
    }
    
    
    private func setBasicInfoViewConstraints() {
        NSLayoutConstraint.activate([
            basicInfoView.leadingAnchor.constraint(equalTo: detailInfoOverlayView.leadingAnchor),
            basicInfoView.heightAnchor.constraint(equalToConstant: 400),
            basicInfoView.widthAnchor.constraint(equalToConstant: 380),
            basicInfoView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 150)
        ])
    }
    
    private func setDetailInfoOverlayConstraints(){
        NSLayoutConstraint.activate([
            detailInfoOverlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            detailInfoOverlayView.heightAnchor.constraint(equalToConstant: 700),
            detailInfoOverlayView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.97),
            detailInfoOverlayView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 700)
        ])
    }
    
    
    private func setScrollViewConstraints(){
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func setContentViewConstraints() {
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollViewConstraints()
        setContentViewConstraints()
    }
}


extension SpeciesDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        //        if(offset > 500){
        //            print(offset)
        //            self.basicInfoView.frame = CGRect(x: 0, y: offset , width: self.view.bounds.size.width, height: 100)
        //        }else{
        //            self.basicInfoView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 100)
        //        }
        print(offset)
        if offset >= 350 {
            print("Pin it now")
            self.basicInfoView.frame = CGRect(x: 50, y: offset - 50, width: self.basicInfoView.bounds.size.width, height: self.basicInfoView.bounds.size.height)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
}

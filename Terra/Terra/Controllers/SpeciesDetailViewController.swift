//
//  ViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices
import Kingfisher

class SpeciesDetailViewController: UIViewController {
    
    var currentSpecies: Species!
    
    var scrollView = UIScrollView()
//    var contentView = UIView()
    
    var basicInfoView = BasicInfoView()
//    var basicInfoViewisPinnedToTop = false
//    var taxonomyView = TaxonomyView()
    
    
    //    private func showWebBrowser(link: URL){
    //        let config = SFSafariViewController.Configuration()
    //        config.entersReaderIfAvailable = true
    //        let safariVC = SFSafariViewController(url: link, configuration: config)
    //        present(safariVC, animated: true)
    //    }
    
    //    private func eventLinkButtonPressed(_ sender: UIButton) {
    //         showWebBrowser(link: URL(string: currentSpecies.donationLink)!)
    //    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    private func setViewsData(){
        basicInfoView.setUIFromSpecies(species: currentSpecies)
//        taxonomyView.setUIFromSpecies(species: currentSpecies)
    }
    
    private func setBackground() {
        view.backgroundColor = .darkGray
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        let imageURL = URL(string: currentSpecies!.detailImage)
        backgroundImageView.kf.setImage(
            with: imageURL,
            placeholder: nil,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(5)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success( _): ()
            //                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure( _): ()
                //                print("Job failed: \(error.localizedDescription)")
            }
        }
        backgroundImageView.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        let backgroundOverlay = GradientView(frame: UIScreen.main.bounds)
        backgroundOverlay.startColor = .clear
        backgroundOverlay.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.8456228596)
        self.view.insertSubview(backgroundOverlay, at: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setViewsData()
        setConstraints()
//        setBackground()
//        taxonomyView.addBlurToView()
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 600)
        
//        basicInfoView.layer.zPosition = 1
//        taxonomyView.layer.zPosition = 0
        
    }
}


//MARK: -- Constraints
extension SpeciesDetailViewController {
    private func setConstraints() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(contentView)
        
        [basicInfoView].forEach{ scrollView.addSubview($0) }
        basicInfoView.translatesAutoresizingMaskIntoConstraints = false
        
//        [basicInfoView, contentView, scrollView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        setBasicInfoViewConstraints()
//        setTaxonomyViewConstraints()
    }
    
    private func setScrollViewConstraints(){
           scrollView.backgroundColor = .blue
           NSLayoutConstraint.activate([
               scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
       }
    
    
    private func setBasicInfoViewConstraints() {
        NSLayoutConstraint.activate([
            basicInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            basicInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            basicInfoView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 150),
            basicInfoView.heightAnchor.constraint(equalToConstant: 375)
        ])
    }
    
//    private func setTaxonomyViewConstraints(){
//        NSLayoutConstraint.activate([
//            taxonomyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            taxonomyView.topAnchor.constraint(equalTo: basicInfoView.bottomAnchor),
//            taxonomyView.widthAnchor.constraint(equalToConstant: 375),
//            taxonomyView.heightAnchor.constraint(equalToConstant: 420)
//
//        ])
//    }
    
    
//    private func setContentViewConstraints() {
//        contentView.backgroundColor = .clear
//        NSLayoutConstraint.activate([
//            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
//        ])
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollViewConstraints()
//        setContentViewConstraints()
    }
}


extension SpeciesDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let initialFrame = CGRect(x: 19.666666666666657 , y: 371.0, width: 394.3333333333333, height: 400.0)
        let y = 375 - (scrollView.contentOffset.y)
        let h = max(100, y)
        
//        print(offset)
//        if offset >= 370 {
//            basicInfoViewisPinnedToTop = true
//            self.basicInfoView.frame = CGRect(x: self.basicInfoView.frame.minX, y: offset - 50, width: self.basicInfoView.bounds.size.width, height: self.basicInfoView.bounds.size.height)
//        } else if offset == 0 && basicInfoViewisPinnedToTop == true {
//            basicInfoViewisPinnedToTop = false
//            self.basicInfoView.frame = initialFrame
//        }
    }
}

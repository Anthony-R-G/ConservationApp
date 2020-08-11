//
//  LearnMoreViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/10/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class LearnMoreViewController: UIViewController {
    //MARK: UI Element Initialization
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView(frame: UIScreen.main.bounds)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .black
        iv.image = #imageLiteral(resourceName: "amurblurtest")
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.delegate = self
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white
        btn.imageView?.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        btn.showsTouchWhenHighlighted = true
        btn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var imageContainer: UIView = {
        let ic = UIView()
        ic.backgroundColor = .darkGray
        return ic
    }()
    
    private lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var textBacking: UIView = {
        let tb = UIView()
        tb.backgroundColor = .clear
        return tb
    }()
    
    private lazy var textContainer: UIView = {
        let tc = UIView()
        tc.backgroundColor = .clear
        return tc
    }()
    
    private lazy var textBody: UILabel = {
        let label = Factory.makeLabel(title: nil, weight: .regular, size: 16, color: .white, alignment: .natural)
        label.numberOfLines = 0
        let text = """
People  usually think of leopards in the savannas of Africa but in the Russian Far East, a rare subspecies has adapted to life in the temperate forests that make up the northern-most part of the species’ range. Similar to other leopards, the Amur leopard can run at speeds of up to 37 miles per hour.

This incredible animal has been reported to leap more than 19 feet horizontally and up to 10 feet vertically.  The Amur leopard is solitary. Nimble-footed and strong, it carries and hides unfinished kills so that they are not taken by other predators.

It has been reported that some males stay with females after mating, and may even help with rearing the young. Several males sometimes follow and fight over a female. They live for 10-15 years, and in captivity up to 20 years. The Amur leopard is also known as the Far East leopard, the Manchurian leopard or the Korean leopard.

Not many people ever see an Amur leopard in the wild. Not surprising, as there are so few of them, but a shame considering how beautiful they are. Thick, luscious, black-ringed coats and a huge furry tails they can wrap around themselves to keep warm.

The good news is, having been driven to the edge of extinction, their numbers appear to be rising thanks to conservation work - we're also able to survey more areas than before and use camera traps to estimate population changes.

The Amur leopard is a nocturnal animal that lives and hunts alone – mainly in the vast forests of Russia and China. During the harsh winter, the hairs of that unique coat can grow up to 7cm long.

Over the years the Amur leopard hasn't just been hunted mercilessly, its homelands have been gradually destroyed by unsustainable logging, forest fires, road building, farming, and industrial development.

But recent research shows conservation work is having a positive effect, and wild Amur leopard numbers are believed to have increased, though there are still only around 90 adults in the wild, in Russia and north-east China.
"""
        label.text = text + text
        return label
    }()
    
    //MARK: -- Properties
    
    var currentSpecies: Species!
    
    private var previousStatusBarHidden = false
    
    
    private var shouldHideStatusBar: Bool {
        let frame = textContainer.convert(textContainer.bounds, to: nil)
        return frame.minY < view.safeAreaInsets.top
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: -- Methods
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func fetchFirebaseImage() {
        FirebaseStorageService.learnMoreOverviewImageManager.getImage(for: currentSpecies.commonName, setTo: headerImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setConstraints()
        fetchFirebaseImage()
    }
}


//MARK: -- ScrollView Delegate Methods
extension LearnMoreViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if previousStatusBarHidden != shouldHideStatusBar {
            
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self = self else { return }
                self.setNeedsStatusBarAppearanceUpdate()
            })
            
            previousStatusBarHidden = shouldHideStatusBar
        }
        
        let offset = scrollView.contentOffset.y
        
        if offset > 100 {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               options: .curveEaseInOut,
                               animations: { [weak self] in
                                guard let self = self else { return }
                                self.backButton.alpha = 0
                    },
                               completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3,
                                      delay: 0,
                                      options: .curveEaseInOut,
                                      animations: { [weak self] in
                                       guard let self = self else { return }
                                        self.backButton.alpha = 1
                           },
                                      completion: nil)
                   }
        }
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension LearnMoreViewController {
    func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(backButton)
        
        let UIElements = [imageContainer, headerImageView, textBacking, textContainer]
        UIElements.forEach { scrollView.addSubview($0) }
        
        textContainer.addSubview(textBody)
    }
    
    func setConstraints() {
        setBackgroundImageConstraints()
        setBackButtonConstraints()
        setScrollViewConstraints()
        
        setImageContainerConstraints()
        setHeaderImageViewConstraints()
        
        setTextBackingConstraints()
        setTextContainerConstraints()
        setTextBodyConstraints()
    }
    
    func setBackgroundImageConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func setBackButtonConstraints() {
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view).inset(25)
            make.leading.equalTo(view).inset(0)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
    }
    
    
    func setScrollViewConstraints() {
        scrollView.snp.makeConstraints {
            make in
            
            make.edges.equalTo(view)
        }
    }
    
    func setImageContainerConstraints() {
        imageContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.height.equalTo(imageContainer.snp.width).multipliedBy(0.7)
        }
    }
    
    func setHeaderImageViewConstraints() {
        headerImageView.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(imageContainer)
            make.top.equalTo(view).priority(.high)
            make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            make.bottom.equalTo(imageContainer.snp.bottom)
        }
    }
    
    func setTextBackingConstraints() {
        textBacking.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(view)
            make.top.equalTo(textContainer)
            make.bottom.equalTo(view)
        }
    }
    
    func setTextContainerConstraints() {
        textContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(imageContainer.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(scrollView)
        }
    }
    
    func setTextBodyConstraints() {
        textBody.snp.makeConstraints {
            make in
            
            make.edges.equalTo(textContainer).inset(14)
        }
    }
}


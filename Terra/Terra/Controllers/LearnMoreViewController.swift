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
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.delegate = self
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    private lazy var imageContainer: UIView = {
        let ic = UIView()
        ic.backgroundColor = .darkGray
        return ic
    }()
    
    private lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "amurleopard")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var textBacking: UIView = {
        let tb = UIView()
        tb.backgroundColor = .black
        return tb
    }()
    
    private lazy var textContainer: UIView = {
        let tc = UIView()
        tc.backgroundColor = .clear
        return tc
    }()
    
    private lazy var textBody: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        let text = """
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        addSubviews()
        setConstraints()
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
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension LearnMoreViewController {
    func addSubviews() {
        view.addSubview(scrollView)
        
        let UIElements = [imageContainer, headerImageView, textBacking, textContainer]
        UIElements.forEach { scrollView.addSubview($0) }
        
        textContainer.addSubview(textBody)
    }
    
    func setConstraints() {
        setScrollViewConstraints()
        
        setImageContainerConstraints()
        setHeaderImageViewConstraints()
        
        setTextBackingConstraints()
        setTextContainerConstraints()
        setTextBodyConstraints()
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


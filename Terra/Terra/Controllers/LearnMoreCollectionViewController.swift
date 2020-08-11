//
//  CollectionViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/11/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class LearnMoreCollectionViewController: UICollectionViewController {
    
    //MARK: -- UI Element Initialization
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white
        btn.imageView?.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        btn.clipsToBounds = true
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.layer.cornerRadius = btn.frame.size.width / 2
        btn.backgroundColor = #colorLiteral(red: 0.1207444444, green: 0.1200340763, blue: 0.1212952659, alpha: 0.6019905822)
        btn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView(frame: UIScreen.main.bounds)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .black
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var blurredEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let bev = UIVisualEffectView(effect: blurEffect)
        bev.frame = view.bounds
        return bev
    }()
    
    //MARK: -- Properties
    fileprivate let cellID = "cellID"
    fileprivate let headerID = "headerID"
    fileprivate let padding: CGFloat = Constants.universalLeadingConstant
    var currentSpecies: Species!
    private var headerView: CollectionViewHeader!
    
    private var previousStatusBarHidden = false
    
    private var shouldHideStatusBar: Bool {
        let frame = collectionView.convert(collectionView.bounds, to: nil)
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
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    @objc private func backButtonPressed() {
        headerView.animator?.stopAnimation(true)
        headerView.animator?.finishAnimation(at: .current)
        dismiss(animated: true, completion: nil)
    }
    
    private func updateBackButtonAlpha(scrollOffset: CGFloat) {
        var newAlpha = CGFloat()
        newAlpha = scrollOffset < 100 ? 1 : 0
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: { [weak self] in
                            guard let self = self else { return }
                            self.backButton.alpha = newAlpha
                },
                           completion: nil)
        }
    }
    
    private func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewLayout()
        setupCollectionView()
        addSubviews()
        setConstraints()
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 0 {
            headerView.animator.fractionComplete = 0
            return
        }
        
        headerView.animator.fractionComplete = abs(contentOffsetY) / 100
        
        if previousStatusBarHidden != shouldHideStatusBar {
            
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self = self else { return }
                self.setNeedsStatusBarAppearanceUpdate()
            })
            
            previousStatusBarHidden = shouldHideStatusBar
        }
        
        let offset = scrollView.contentOffset.y
        updateBackButtonAlpha(scrollOffset: offset)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as? CollectionViewHeader)!
        headerView.configureViewFromSpecies(species: currentSpecies)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 320)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
}

extension LearnMoreCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * padding, height: 50)
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension LearnMoreCollectionViewController {
    func addSubviews() {
        view.addSubview(backButton)
    }
    
    func setConstraints() {
        setBackButtonConstraints()
    }
    
    func setBackButtonConstraints() {
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view).inset(40)
            make.leading.equalTo(view).inset(20)
            make.height.equalTo(backButton.frame.height)
            make.width.equalTo(backButton.frame.width)
        }
    }
}




//
//  CollectionViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/11/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class LearnMoreCollectionViewController: UIViewController {
    
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = StretchyHeaderLayout()
        layout.sectionInset = UIEdgeInsets(top: Constants.universalLeadingConstant,
                                           left: Constants.universalLeadingConstant,
                                           bottom: Constants.universalLeadingConstant,
                                           right: Constants.universalLeadingConstant)
//        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 200)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.contentInsetAdjustmentBehavior = .never
        
        cv.register(UICollectionViewCell.self,
                    forCellWithReuseIdentifier: cellID)
        cv.register(CollectionViewHeader.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: headerID)
        
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    //MARK: -- Properties
    private let cellID = "cellID"
    private let headerID = "headerID"
    
    var currentSpecies: Species!
    private var headerView: CollectionViewHeader!
    
    let data = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", "Lorem ipsum dolor."]
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: -- Methods
    
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
    
    private func fetchFirebaseData() {
        FirebaseStorageService.detailImageManager.getImage(for: currentSpecies.commonName,
                                                           setTo: backgroundImageView)
    }
    
    private func updateHeaderAnimator(with offset: CGFloat) {
        if offset > 0 {
            headerView.animator.fractionComplete = 0
            return
        }
        
        headerView.animator.fractionComplete = abs(offset) / 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        addSubviews()
        setConstraints()
        fetchFirebaseData()
    }
}

//MARK: -- CollectionView DataSource Methods
extension LearnMoreCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                                                      for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5159728168)
        cell.layer.cornerRadius = 39
//        cell.label.text = data[indexPath.item]
        return cell
    }
    
}

//MARK: -- CollectionView Delegate Methods
extension LearnMoreCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        headerView = (collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                      withReuseIdentifier: headerID,
                                                                      for: indexPath) as? CollectionViewHeader)!
        
        headerView.configureViewFromSpecies(species: currentSpecies)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 320)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        updateBackButtonAlpha(scrollOffset: contentOffsetY)
        updateHeaderAnimator(with: contentOffsetY)
    }
}

extension LearnMoreCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 2 * Constants.universalLeadingConstant, height: 300)
    }
}

//MARK: -- Add Subviews & Constraints
fileprivate extension LearnMoreCollectionViewController {
    func addSubviews() {
        blurredEffectView.contentView.addSubview(collectionView)
        view.addSubview(blurredEffectView)
        view.addSubview(backButton)
    }
    
    func setConstraints() {
        setBackgroundImageConstraints()
        setBackButtonConstraints()
        setCollectionViewConstraints()
    }
    
    func setBackgroundImageConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setBackButtonConstraints() {
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view).inset(40)
            make.leading.equalTo(view).inset(20)
            make.height.equalTo(backButton.frame.height)
            make.width.equalTo(backButton.frame.width)
        }
    }
    
    func setCollectionViewConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}




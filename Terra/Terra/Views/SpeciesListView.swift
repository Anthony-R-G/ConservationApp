////
////  SpeciesListView.swift
////  Terra
////
////  Created by Anthony Gonzalez on 9/6/20.
////  Copyright © 2020 Antnee. All rights reserved.
////
//
//import UIKit
//
//protocol SpeciesListViewDelegate: class {
//    func earthButtonPressed()
//    func searchTextSet()
//    
//}
//
//final class SpeciesListView: UIView {
//    
//    private lazy var searchBar: UISearchBar = {
//        let sb = UISearchBar()
//        sb.backgroundColor = .clear
//        sb.barStyle = .black
//        sb.backgroundImage = UIImage()
//        sb.alpha = 0
//        sb.keyboardAppearance = .dark
//        sb.showsCancelButton = true
//        sb.placeholder = "Search species..."
//        sb.tintColor = .systemBlue
//        sb.delegate = self
//        return sb
//    }()
//    
//    private lazy var filterTabBar: RedListFilterTabBar = {
//        let tb = RedListFilterTabBar(frame: CGRect(origin: .zero, size: CGSize(
//            width: frame.width,
//            height: 30.deviceScaled)))
//        tb.selectedItem = tb.items![0]
//        tb.delegate = self
//        return tb
//    }()
//    
//    private lazy var searchBarButton: UIButton = {
//        let btn = UIButton()
//        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
//        btn.tintColor = .white
//        btn.addTarget(self, action: #selector(expandSearchBar), for: .touchUpInside)
//        return btn
//    }()
//    
//    private lazy var headerImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.image = #imageLiteral(resourceName: "Species List Header")
//        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
//        return iv
//    }()
//    
//    private lazy var terraTitleLabel: UILabel = {
//        return Factory.makeLabel(title: "TERRA",
//                                 fontWeight: .black,
//                                 fontSize: 30,
//                                 widthAdjustsFontSize: true,
//                                 color: Constants.Color.titleLabelColor,
//                                 alignment: .left)
//    }()
//    
//    private lazy var noResultsFoundLabel: UILabel = {
//        let label = Factory.makeLabel(title: "No Species Found",
//                                      fontWeight: .regular,
//                                      fontSize: Constants.FontHierarchy.secondaryContentFontSize,
//                                      widthAdjustsFontSize: true,
//                                      color: .red,
//                                      alignment: .center)
//        label.frame = CGRect(
//            origin: .zero,
//            size: CGSize(
//                width: collectionView.bounds.width,
//                height: collectionView.bounds.height))
//        
//        collectionView.backgroundView = label
//        label.isHidden = true
//        return label
//    }()
//    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: view.frame.width, height: 227.deviceScaled)
//        layout.minimumLineSpacing = 0
//        
//        let cv = UICollectionView(
//            frame: .zero,
//            collectionViewLayout: layout)
//        
//        cv.backgroundColor = .clear
//        cv.register(SpeciesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
//        //        cv.dataSource = self
//        
//        cv.delegate = self
//        return cv
//    }()
//    
//    private lazy var searchBarLeadingAnchorConstraint: NSLayoutConstraint = {
//        return searchBar.leadingAnchor.constraint(
//            equalTo: view.trailingAnchor,
//            constant: -Constants.spacing)
//    }()
//    
//    private lazy var earthButtonLeadingAnchorConstraint: NSLayoutConstraint = {
//        return earthButton.leadingAnchor.constraint(
//            equalTo: view.leadingAnchor,
//            constant: Constants.spacing)
//    }()
//    
//    private lazy var rightSwipeGesture: UISwipeGestureRecognizer = {
//        let gesture = UISwipeGestureRecognizer(
//            target: self,
//            action: #selector(handleCollectionViewSwipe(_:)))
//        gesture.direction = .right
//        return gesture
//    }()
//    
//    private lazy var leftSwipeGesture: UISwipeGestureRecognizer = {
//        let gesture = UISwipeGestureRecognizer(
//            target: self,
//            action: #selector(handleCollectionViewSwipe(_:)))
//        gesture.direction = .left
//        return gesture
//    }()
//    
//    private lazy var earthButton: UIButton = {
//        let btn = UIButton()
//        btn.setImage(#imageLiteral(resourceName: "MapVCGlyph"), for: .normal)
//        btn.addTarget(
//            self,
//            action: #selector(earthButtonPressed),
//            for: .touchUpInside)
//        btn.alpha = 1.0
//        btn.tintColor = .systemBlue
//        return btn
//    }()
//    
//    
//    private var isSearching: Bool = false
//    
//    private var selectedTab = 0
//    
//    private lazy var dataSource = makeDataSource()
//}
//
//
////MARK: -- Add Subviews & Constraints
//
//fileprivate extension SpeciesListView {
//    
//    func addSubviews() {
//        [headerImageView, earthButton, terraTitleLabel, searchBarButton, searchBar, collectionView, filterTabBar].forEach { view.addSubview($0) }
//    }
//    
//    func setConstraints() {
//        setHeaderImageViewConstraints()
//        
//        setEarthButtonConstraints()
//        setTerraTitleLabelConstraints()
//        setSearchBarButtonConstraints()
//        setSearchBarConstraints()
//        
//        setSpeciesCollectionViewConstraints()
//        setFilterTabBarConstraints()
//    }
//    
//    func setHeaderImageViewConstraints() {
//        headerImageView.snp.makeConstraints { (make) in
//            make.top.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(collectionView.snp.top)
//        }
//    }
//    
//    func setTerraTitleLabelConstraints() {
//        terraTitleLabel.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().inset(50.deviceScaled)
//            make.leading.equalTo(earthButton.snp.trailing).offset(Constants.spacing/2)
//            make.height.equalTo(25.deviceScaled)
//            make.width.equalTo(100.deviceScaled)
//        }
//    }
//    
//    func setEarthButtonConstraints() {
//        earthButton.snp.makeConstraints { (make) in
//            earthButtonLeadingAnchorConstraint.isActive = true
//            make.height.width.equalTo(25.deviceScaled)
//            make.centerY.equalTo(terraTitleLabel)
//        }
//    }
//    
//    func setSearchBarButtonConstraints() {
//        searchBarButton.snp.makeConstraints { (make) in
//            make.height.width.equalTo(40.deviceScaled)
//            make.centerY.equalTo(terraTitleLabel)
//            make.trailing.equalToSuperview().inset(Constants.spacing)
//        }
//    }
//    
//    func setSearchBarConstraints() {
//        searchBar.snp.makeConstraints { (make) in
//            searchBarLeadingAnchorConstraint.isActive = true
//            make.trailing.equalToSuperview().inset(Constants.spacing)
//            make.centerY.equalTo(searchBarButton)
//        }
//    }
//    
//    func setFilterTabBarConstraints() {
//        filterTabBar.snp.makeConstraints { (make) in
//            make.top.equalTo(terraTitleLabel.snp.bottom).offset(10.deviceScaled)
//            make.centerX.equalToSuperview()
//            make.height.width.equalTo(filterTabBar.frame.size)
//        }
//    }
//    
//    func setSpeciesCollectionViewConstraints() {
//        collectionView.snp.makeConstraints { (make) in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(filterTabBar.snp.bottom)
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//}

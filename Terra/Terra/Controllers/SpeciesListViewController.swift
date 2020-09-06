//
//  SpeciesListViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

fileprivate typealias SpeciesDataSource = UICollectionViewDiffableDataSource<SpeciesListViewController.Section, Species>
fileprivate typealias SpeciesSnapshot = NSDiffableDataSourceSnapshot<SpeciesListViewController.Section, Species>

final class SpeciesListViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundColor = .clear
        sb.barStyle = .black
        sb.backgroundImage = UIImage()
        sb.alpha = 0
        sb.keyboardAppearance = .dark
        sb.showsCancelButton = true
        sb.placeholder = "Search species..."
        sb.tintColor = .systemBlue
        sb.delegate = self
        return sb
    }()
    
    private lazy var filterTabBar: RedListFilterTabBar = {
        let tb = RedListFilterTabBar(frame: CGRect(origin: .zero, size: CGSize(
            width: view.frame.width,
            height: 30.deviceScaled)))
        tb.selectedItem = tb.items![0]
        tb.delegate = self
        return tb
    }()
    
    private lazy var searchBarButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(expandSearchBar), for: .touchUpInside)
        return btn
    }()
    
    private lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Species List Header")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var terraTitleLabel: UILabel = {
        return Factory.makeLabel(title: "TERRA",
                                 fontWeight: .black,
                                 fontSize: 30,
                                 widthAdjustsFontSize: true,
                                 color: Constants.Color.titleLabelColor,
                                 alignment: .left)
    }()
    
    private lazy var noResultsFoundLabel: UILabel = {
        let label = Factory.makeLabel(title: "No Species Found",
                                      fontWeight: .regular,
                                      fontSize: Constants.FontHierarchy.secondaryContentFontSize,
                                      widthAdjustsFontSize: true,
                                      color: .red,
                                      alignment: .center)
        label.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: collectionView.bounds.width,
                height: collectionView.bounds.height))
        
        collectionView.backgroundView = label
        label.isHidden = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: 227.deviceScaled)
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        
        cv.backgroundColor = .clear
        cv.register(SpeciesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        //        cv.dataSource = self
        
        cv.delegate = self
        return cv
    }()
    
    private lazy var searchBarLeadingAnchorConstraint: NSLayoutConstraint = {
        return searchBar.leadingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -Constants.spacing)
    }()
    
    private lazy var earthButtonLeadingAnchorConstraint: NSLayoutConstraint = {
        return earthButton.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: Constants.spacing)
    }()
    
    private lazy var rightSwipeGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleCollectionViewSwipe(_:)))
        gesture.direction = .right
        return gesture
    }()
    
    private lazy var leftSwipeGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleCollectionViewSwipe(_:)))
        gesture.direction = .left
        return gesture
    }()
    
    private lazy var earthButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "MapVCGlyph"), for: .normal)
        btn.addTarget(
            self,
            action: #selector(earthButtonPressed),
            for: .touchUpInside)
        btn.alpha = 1.0
        btn.tintColor = .systemBlue
        return btn
    }()
    
    //MARK: -- Properties
    
    private var viewModel: SpeciesViewModel!
    
    private var isSearching: Bool = false
    
    private var selectedTab = 0
    
    private lazy var dataSource = makeDataSource()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: -- Methods
    
    @objc private func earthButtonPressed() {
        let mapVC = MGLMapViewController(speciesData: viewModel.allSpecies)
        mapVC.modalPresentationStyle = .fullScreen
        Utilities.sendHapticFeedback(action: .itemSelected)
        present(mapVC, animated: true, completion: nil)
    }
    
    @objc private func handleCollectionViewSwipe(_ sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case .left:
            selectedTab += 1
            if selectedTab == 4 { selectedTab = 0 }
            
        case .right:
            selectedTab -= 1
            if selectedTab == -1 { selectedTab = 3 }
            
        default: ()
        }
        
        filterTabBar.selectedItem = filterTabBar.items![selectedTab]
        viewModel.updateRedListCategoryFilteredAnimals(from: filterTabBar.selectedItem!.tag)
    }
    
    @objc private func expandSearchBar() {
        searchBarLeadingAnchorConstraint.constant = -400.deviceScaled
        earthButtonLeadingAnchorConstraint.constant = -200.deviceScaled
        searchBar.alpha = 1
        searchBarButton.alpha = 0
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
            
        }) { [weak self] result in
            guard let self = self else { return }
            self.searchBar.becomeFirstResponder()
        }
        isSearching = true
    }
    
    private func dismissSearchBar() {
        searchBarLeadingAnchorConstraint.constant = -Constants.spacing
        earthButtonLeadingAnchorConstraint.constant = Constants.spacing
        searchBar.alpha = 0
        searchBarButton.alpha = 1
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
            
        }) { [weak self] result in
            guard let self = self else { return }
            self.searchBar.resignFirstResponder()
        }
        isSearching = false
    }
    
    private func makeDataSource() -> SpeciesDataSource {
        let dataSource = SpeciesDataSource(collectionView: collectionView,
                                       cellProvider: { (collectionView, indexPath, species) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.cellReuseIdentifier,
                for: indexPath) as? SpeciesCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(from: species)
            return cell
        })
        return dataSource
    }
    
    private func makeSnapshot(from species: [Species]) {
        var snapshot = SpeciesSnapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(species)
        
        noResultsFoundLabel.isHidden = snapshot.numberOfItems > 0 ? true: false
       
        dataSource.apply(snapshot, animatingDifferences: true)
       
    }
    
    private func addGestureRecognizers() {
        collectionView.addGestureRecognizer(rightSwipeGesture)
        collectionView.addGestureRecognizer(leftSwipeGesture)
    }
    
    //MARK: --Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SpeciesViewModel(delegate: self)
        viewModel.fetchSpeciesData()
        addSubviews()
        setConstraints()
        addGestureRecognizers()
    }
}

//MARK: -- CollectionView Delegate Methods

extension SpeciesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        Utilities.sendHapticFeedback(action: .itemSelected)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                           didSelectItemAt indexPath: IndexPath) {
           
           guard let selectedSpecies = dataSource.itemIdentifier(for: indexPath) else { return }
           let coverVC = SpeciesCoverViewController(viewModel: DetailPageStrategyViewModel(species: selectedSpecies))
           let navVC = NavigationController(rootViewController: coverVC)
           navVC.modalPresentationStyle = .fullScreen
           present(navVC, animated: true, completion: nil)
       }
}

//MARK: --SearchBar Delegate Methods
extension SpeciesListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissSearchBar()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissSearchBar()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateSearchString(newString: searchText)
    }
}

//MARK: -- Tab Bar Delegate
extension SpeciesListViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        selectedTab = item.tag
        viewModel.updateRedListCategoryFilteredAnimals(from: item.tag)
    }
}

//MARK: -- Custom Delegate Implementations
extension SpeciesListViewController: SpeciesViewModelDelegate {
    func fetchCompleted() {
        makeSnapshot(from: viewModel.searchFilteredSpecies)
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesListViewController {
    
    func addSubviews() {
        [headerImageView, earthButton, terraTitleLabel, searchBarButton, searchBar, collectionView, filterTabBar].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        setHeaderImageViewConstraints()
        
        setEarthButtonConstraints()
        setTerraTitleLabelConstraints()
        setSearchBarButtonConstraints()
        setSearchBarConstraints()
        
        setSpeciesCollectionViewConstraints()
        setFilterTabBarConstraints()
    }
    
    func setHeaderImageViewConstraints() {
        headerImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top)
        }
    }
    
    func setTerraTitleLabelConstraints() {
        terraTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(50.deviceScaled)
            make.leading.equalTo(earthButton.snp.trailing).offset(Constants.spacing/2)
            make.height.equalTo(25.deviceScaled)
            make.width.equalTo(100.deviceScaled)
        }
    }
    
    func setEarthButtonConstraints() {
        earthButton.snp.makeConstraints { (make) in
            earthButtonLeadingAnchorConstraint.isActive = true
            make.height.width.equalTo(25.deviceScaled)
            make.centerY.equalTo(terraTitleLabel)
        }
    }
    
    func setSearchBarButtonConstraints() {
        searchBarButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(40.deviceScaled)
            make.centerY.equalTo(terraTitleLabel)
            make.trailing.equalToSuperview().inset(Constants.spacing)
        }
    }
    
    func setSearchBarConstraints() {
        searchBar.snp.makeConstraints { (make) in
            searchBarLeadingAnchorConstraint.isActive = true
            make.trailing.equalToSuperview().inset(Constants.spacing)
            make.centerY.equalTo(searchBarButton)
        }
    }
    
    func setFilterTabBarConstraints() {
        filterTabBar.snp.makeConstraints { (make) in
            make.top.equalTo(terraTitleLabel.snp.bottom).offset(10.deviceScaled)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(filterTabBar.frame.size)
        }
    }
    
    func setSpeciesCollectionViewConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(filterTabBar.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SpeciesListViewController {
    fileprivate enum Section {
        case main
    }
}



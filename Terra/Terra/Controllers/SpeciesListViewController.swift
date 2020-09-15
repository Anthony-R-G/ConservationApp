//
//  SpeciesListViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import Combine

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
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return sb
    }()
    
    private lazy var redListTabBar: RedListFilterTabBar = {
        let tb = RedListFilterTabBar(frame: CGRect(
            origin: .zero, size: CGSize(
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
    
    private lazy var earthButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "MapVCGlyph"), for: .normal)
        btn.addTarget(
            self,
            action: #selector(earthButtonPressed),
            for: .touchUpInside)
        btn.alpha = 1.0
        btn.tintColor = .white
        
        return btn
    }()
    
    private lazy var terraTitleLabel: UILabel = {
        return Factory.makeLabel(title: "TERRA",
                                 fontWeight: .black,
                                 fontSize: 25,
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
        cv.delegate = self
        return cv
    }()
    
    private lazy var searchBarDisabledLeadingAnchor: NSLayoutConstraint = {
        return searchBar.leadingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -Constants.padding)
    }()
    
    private lazy var searchBarEnabledLeadingAnchor: NSLayoutConstraint = {
        return searchBar.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: Constants.padding)
    }()
    
    private lazy var searchBarEnabledTrailingAnchor: NSLayoutConstraint = {
        return searchBar.trailingAnchor.constraint(
            equalTo: earthButton.leadingAnchor,
            constant: -20)
    }()
    
    private lazy var terraTitleLabelLeadingAnchorConstraint: NSLayoutConstraint = {
        return terraTitleLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: Constants.padding)
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
    
    //MARK: -- Properties
    
    private var isSearching: Bool = false
    
    private lazy var viewModel: SpeciesListViewModel = {
        let viewModel = SpeciesListViewModel(searchPublisher: search, selectedFilterPublisher: selectedTab)
        return viewModel
    }()
    
    private lazy var dataSource: SpeciesDataSource = makeDataSource()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let selectedTab = CurrentValueSubject<Int, Never>(0)
    
    private let search = CurrentValueSubject<String, Never>("")
    
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
        Utilities.sendHapticFeedback(action: .selectionChanged)
        sender.direction == .left ? incrementSelectedTab() : decrementSelectedTab()
        redListTabBar.selectedItem = redListTabBar.items![selectedTab.value]
    }
    
    private func incrementSelectedTab() {
        selectedTab.value += 1
        if selectedTab.value == 4 { selectedTab.value = 0 }
    }
    
    private func decrementSelectedTab() {
        selectedTab.value -= 1
        if selectedTab.value == -1 { selectedTab.value = 3 }
    }
    
    @objc private func expandSearchBar() {
        searchBarDisabledLeadingAnchor.isActive = false
        searchBarEnabledLeadingAnchor.isActive = true
        searchBarEnabledTrailingAnchor.isActive = true
        terraTitleLabelLeadingAnchorConstraint.constant = -200.deviceScaled
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
        
        searchBarEnabledLeadingAnchor.isActive = false
        searchBarEnabledTrailingAnchor.isActive = false
        searchBarDisabledLeadingAnchor.isActive = true
        terraTitleLabelLeadingAnchorConstraint.constant = Constants.padding
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
        let dataSource = SpeciesDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, species) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: Constants.cellReuseIdentifier,
                    for: indexPath) as? SpeciesCollectionViewCell
                    else { return UICollectionViewCell() }
                cell.configureCell(from: species)
                return cell
        })
        return dataSource
    }
    
    private func makeSnapshot(from species: [Species]) {
        var snapshot = SpeciesSnapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(species)
        
        noResultsFoundLabel.isHidden = isSearching && snapshot.numberOfItems == 0 ? false: true
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func bindViewModel() {
        viewModel.$searchFilteredSpecies
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] (speciesData) in
                    guard let self = self else { return }
                    self.makeSnapshot(from: speciesData)
            })
            .store(in: &subscriptions)
    }
    
    private func addGestureRecognizers() {
        collectionView.addGestureRecognizer(rightSwipeGesture)
        collectionView.addGestureRecognizer(leftSwipeGesture)
    }
    
    //MARK: --Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchSpeciesData()
        bindViewModel()
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
        let coverVC = SpeciesCoverViewController(viewModel: SpeciesDetailViewModel(species: selectedSpecies))
        let navVC = NavigationController(rootViewController: coverVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
}

//MARK: --SearchBar Delegate Methods
extension SpeciesListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search.send("")
        dismissSearchBar()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search.send(searchText)
    }
}

//MARK: -- Tab Bar Delegate
extension SpeciesListViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        Utilities.sendHapticFeedback(action: .selectionChanged)
        selectedTab.value = item.tag
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesListViewController {
    
    func addSubviews() {
        [earthButton, terraTitleLabel, searchBarButton, searchBar, collectionView, redListTabBar]
            .forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        setEarthButtonConstraints()
        setTerraTitleLabelConstraints()
        setSearchBarButtonConstraints()
        setSearchBarConstraints()
        
        setSpeciesCollectionViewConstraints()
        setFilterTabBarConstraints()
    }
    
    func setTerraTitleLabelConstraints() {
        terraTitleLabel.snp.makeConstraints { (make) in
            terraTitleLabelLeadingAnchorConstraint.isActive = true
            make.top.equalToSuperview().inset(50.deviceScaled)
            make.height.equalTo(20.deviceScaled)
            make.width.equalTo(100.deviceScaled)
        }
    }
    
    func setEarthButtonConstraints() {
        earthButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Constants.padding)
            make.height.width.equalTo(35.deviceScaled)
            make.centerY.equalTo(terraTitleLabel)
        }
    }
    
    func setSearchBarButtonConstraints() {
        searchBarButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(40.deviceScaled)
            make.centerY.equalTo(terraTitleLabel)
            make.trailing.equalTo(earthButton.snp.leading).offset(-Constants.padding/2)
        }
    }
    
    func setSearchBarConstraints() {
        searchBar.snp.makeConstraints { (make) in
            searchBarDisabledLeadingAnchor.isActive = true
            make.centerY.equalTo(searchBarButton)
        }
    }
    
    func setFilterTabBarConstraints() {
        redListTabBar.snp.makeConstraints { (make) in
            make.top.equalTo(terraTitleLabel.snp.bottom).offset(5.deviceScaled)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(redListTabBar.frame.size)
        }
    }
    
    func setSpeciesCollectionViewConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(redListTabBar.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SpeciesListViewController {
    fileprivate enum Section {
        case main
    }
}



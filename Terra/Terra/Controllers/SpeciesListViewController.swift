//
//  SpeciesListViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class SpeciesListViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    private lazy var scrollView: UIScrollView = {
        return UIScrollView()
    }()
    
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundColor = .clear
        sb.barStyle = .black
        sb.backgroundImage = UIImage()
        sb.alpha = 0
        sb.keyboardAppearance = .dark
        sb.showsCancelButton = true
        sb.placeholder = "Search species..."
        sb.tintColor = Constants.red
        return sb
    }()
    
    private lazy var topToolBar: toolBar = {
        let tb = toolBar(frame: .zero, strategy: ToolBarListVCStrategy())
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
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "listVCbackground")
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        view.insertSubview(iv, at: 0)
        return iv
    }()
    
    
    private lazy var terraTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Terra",
                                 weight: .bold,
                                 size: 36,
                                 color: Constants.titleLabelColor,
                                 alignment: .left)
    }()
    
    private lazy var criticalSpeciesLabel: UILabel = {
        return Factory.makeLabel(title: "CRITICALLY ENDANGERED",
                                 weight: .medium,
                                 size: 19,
                                 color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7993899829),
                                 alignment: .left)
    }()
    
    private lazy var endangeredSpeciesLabel: UILabel = {
        return Factory.makeLabel(title: "ENDANGERED",
                                 weight: .medium,
                                 size: 19,
                                 color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7993899829),
                                 alignment: .left)
    }()
    
    private lazy var vulnerableSpeciesLabel: UILabel = {
        return Factory.makeLabel(title: "VULNERABLE",
                                 weight: .medium,
                                 size: 19,
                                 color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7993899829),
                                 alignment: .left)
    }()
    
    private lazy var collectionView: UICollectionView = {
        Factory.makeCollectionView()
    }()
    
    private lazy var searchBarLeadingAnchorConstraint: NSLayoutConstraint = {
        return searchBar.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.universalLeadingConstant)
    }()
    
    private lazy var terraTitleLabelLeadingAnchorConstraint: NSLayoutConstraint = {
        return terraTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.universalLeadingConstant)
    }()
    
    //MARK: -- Properties
    
    private var viewModel: SpeciesViewModel!
    
    private var isSearching: Bool = false
    
    //MARK: -- Methods
    
    @objc private func expandSearchBar() {
        searchBarLeadingAnchorConstraint.constant = -400
        terraTitleLabelLeadingAnchorConstraint.constant = -100
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
        searchBarLeadingAnchorConstraint.constant = -Constants.universalLeadingConstant
        terraTitleLabelLeadingAnchorConstraint.constant = Constants.universalLeadingConstant
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
    
    private func presentModally(_ viewController: UIViewController) {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        let rootViewController = window?.rootViewController
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    private func setDatasourceAndDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
        topToolBar.delegate = self
        searchBar.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchSpeciesData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel = SpeciesViewModel(delegate: self)
        
        addSubviews()
        setConstraints()
        
        setDatasourceAndDelegates()
        topToolBar.highlightButton(button: .buttonOne)
        
    }
}

//MARK: -- CollectionView DataSource Methods
extension SpeciesListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.totalSpeciesCount == 0 && isSearching {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
            noDataLabel.text          = "No Species Found"
            noDataLabel.textColor     = UIColor.red
            noDataLabel.textAlignment = .center
            collectionView.backgroundView  = noDataLabel
        }
        return viewModel.totalSpeciesCount
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let speciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
        
        let specificAnimal = viewModel.specificSpecies(at: indexPath.row)
        speciesCell.configureCellUI(from: specificAnimal)
        return speciesCell
    }
}

//MARK: -- CollectionView Delegate Methods

extension SpeciesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 227)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let specificAnimal = viewModel.specificSpecies(at: indexPath.row)
        
        let detailVC = SpeciesDetailViewController()
        detailVC.currentSpecies = specificAnimal
        
        presentModally(detailVC)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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

//MARK: -- Custom Delegate Implementations
extension SpeciesListViewController: SpeciesViewModelDelegate {
    func fetchCompleted() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}

extension SpeciesListViewController: CustomToolBarDelegate {
    func buttonPressed(_ sender: UIButton) {
        guard let buttonOption = ToolBarSelectedButton(rawValue: sender.tag) else { return }
        topToolBar.highlightButton(button: buttonOption)
        viewModel.updateRedListCategoryFilteredAnimals(from: buttonOption)
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesListViewController {
    
    func addSubviews() {
        let UIElements = [terraTitleLabel, searchBarButton, searchBar, collectionView, topToolBar]
        UIElements.forEach { view.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setHeaderImageViewConstraints()
        
        setTerraTitleLabelConstraints()
        setSearchBarButtonConstraints()
        setSearchBarConstraints()
        
        setSpeciesCollectionViewConstraints()
        setToolBarConstraints()
    }
    
    func setHeaderImageViewConstraints() {
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor)
        ])
    }
    
    
    func setTerraTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            terraTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            terraTitleLabelLeadingAnchorConstraint,
            terraTitleLabel.heightAnchor.constraint(equalToConstant: 25),
            terraTitleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setSearchBarButtonConstraints() {
        NSLayoutConstraint.activate([
            searchBarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.universalLeadingConstant),
            searchBarButton.centerYAnchor.constraint(equalTo: terraTitleLabel.centerYAnchor),
            searchBarButton.heightAnchor.constraint(equalToConstant: 40),
            searchBarButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBarLeadingAnchorConstraint,
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.universalLeadingConstant),
            searchBar.centerYAnchor.constraint(equalTo: searchBarButton.centerYAnchor),
        ])
    }
    
    func setToolBarConstraints() {
        NSLayoutConstraint.activate([
            topToolBar.topAnchor.constraint(equalTo: terraTitleLabel.bottomAnchor, constant: 10),
            topToolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topToolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topToolBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setSpeciesCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topToolBar.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}

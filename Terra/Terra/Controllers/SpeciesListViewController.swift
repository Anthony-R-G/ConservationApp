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
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "listVCbackground")
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        view.insertSubview(iv, at: 0)
        return iv
    }()
    
    private lazy var backgroundGradientOverlay: GradientView = {
        let gv = GradientView()
        gv.translatesAutoresizingMaskIntoConstraints = false
        gv.startColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.1955800514)
        gv.endColor = #colorLiteral(red: 0.06042958051, green: 0.07334413379, blue: 0.2174944878, alpha: 0.8456228596)
        view.insertSubview(gv, at: 1)
        return gv
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
    
    private lazy var speciesCollectionView: UICollectionView = {
        Factory.makeCollectionView()
    }()
    
    private lazy var searchBarLeadingAnchorConstraint: NSLayoutConstraint = {
        return searchBar.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.universalLeadingConstant)
    }()
    
    private lazy var terraTitleLabelLeadingAnchorConstraint: NSLayoutConstraint = {
        return terraTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.universalLeadingConstant)
    }()
    
    //MARK: -- Properties
    
    private var animalData: [Species] = []
    
    
    private var redListCategoryFilteredAnimals: [Species] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.speciesCollectionView.reloadData()
            }
        }
    }
    
    var searchFilteredSpecies: [Species] {
        get {
            guard let searchString = searchString else { return redListCategoryFilteredAnimals }
            guard searchString != ""  else { return redListCategoryFilteredAnimals }
            return Species.getFilteredSpeciesByName(arr: redListCategoryFilteredAnimals, searchString: searchString)
        }
    }
    
    private var searchString: String? = nil {
        didSet {
            speciesCollectionView.reloadData()
        }
    }
    
    //MARK: -- Methods
    
    @objc private func expandSearchBar() {
        searchBarLeadingAnchorConstraint.constant = -400
        terraTitleLabelLeadingAnchorConstraint.constant = -100
        searchBar.alpha = 1
        searchBarButton.alpha = 0
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
            
        }) { (result) in
            self.searchBar.becomeFirstResponder()
        }
    }
    
    private func dismissSearchBar() {
        searchBarLeadingAnchorConstraint.constant = -Constants.universalLeadingConstant
        terraTitleLabelLeadingAnchorConstraint.constant = Constants.universalLeadingConstant
        searchBar.alpha = 0
        searchBarButton.alpha = 1
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        }) { (result) in
            self.searchBar.resignFirstResponder()
        }
    }
    
    private func showModally(_ viewController: UIViewController) {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        let rootViewController = window?.rootViewController
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    private func loadSpeciesDataFromFirebase() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            FirestoreService.manager.getAllSpeciesData() { (result) in
                switch result {
                case .success(let speciesData):
                    self.animalData = speciesData
                    self.redListCategoryFilteredAnimals = speciesData
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setDatasourceAndDelegates() {
        speciesCollectionView.dataSource = self
        speciesCollectionView.delegate = self
        topToolBar.delegate = self
        searchBar.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubviews()
        setConstraints()
        loadSpeciesDataFromFirebase()
        setDatasourceAndDelegates()
        topToolBar.highlightButton(button: .buttonOne)
    }
}

//MARK: -- CollectionView DataSource Methods
extension SpeciesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchFilteredSpecies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let speciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
        let specificAnimal = searchFilteredSpecies[indexPath.row]
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
        let specificAnimal = searchFilteredSpecies[indexPath.row]
        
        let detailVC = SpeciesDetailViewController()
        detailVC.currentSpecies = specificAnimal
        
        showModally(detailVC)
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
        searchString = searchText
    }
}

//MARK: -- Custom Delegate Implementations
extension SpeciesListViewController: BottomBarDelegate {
    func buttonPressed(_ sender: UIButton) {
        guard let buttonOption = ButtonOption(rawValue: sender.tag) else { return }
        topToolBar.highlightButton(button: buttonOption)
        switch buttonOption {
        case .buttonOne:
            redListCategoryFilteredAnimals = animalData
            
        case .buttonTwo:
            redListCategoryFilteredAnimals = Species.getFilteredSpeciesByConservationStatus(arr: animalData, by: .critical)
            
        case .buttonThree:
            redListCategoryFilteredAnimals = Species.getFilteredSpeciesByConservationStatus(arr: animalData, by: .endangered)
            
        case .buttonFour:
            redListCategoryFilteredAnimals =  Species.getFilteredSpeciesByConservationStatus(arr: animalData, by: .vulnerable)
        }
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesListViewController {
    
    func addSubviews() {
        let mainViewUIElements = [terraTitleLabel, searchBarButton, searchBar, speciesCollectionView, topToolBar]
        mainViewUIElements.forEach { view.addSubview($0) }
        mainViewUIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setTerraTitleLabelConstraints()
        setSearchBarButtonConstraints()
        setSearchBarConstraints()
        
        setSpeciesCollectionViewConstraints()
        setToolBarConstraints()
        
    }
    
    func setBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: speciesCollectionView.topAnchor)
        ])
    }
    
    func setBackgroundGradientOverlayConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundGradientOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundGradientOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundGradientOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
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
            speciesCollectionView.topAnchor.constraint(equalTo: topToolBar.bottomAnchor, constant: 0),
            speciesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            speciesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            speciesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}

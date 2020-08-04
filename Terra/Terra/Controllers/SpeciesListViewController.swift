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
        sb.placeholder = "Search Species..."
        return sb
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "listVCbackground")
        iv.contentMode = UIView.ContentMode.scaleAspectFill
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
                                 color: #colorLiteral(red: 0.9257398248, green: 1, blue: 0.7623538375, alpha: 1),
                                 alignment: .left)
    }()
    
    private lazy var subtitleLabel: UILabel = {
        return  Factory.makeLabel(title: "Protect the earth's biodiversity",
                                  weight: .light,
                                  size: 20,
                                  color: #colorLiteral(red: 0.6699403524, green: 0.6602986455, blue: 0.7864833474, alpha: 1),
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
    
    private lazy var criticalCollectionView: UICollectionView = {
        Factory.makeCollectionView(superview: view)
    }()
    
    private lazy var endangeredCollectionView: UICollectionView = {
        Factory.makeCollectionView(superview: view)
    }()
    
    private lazy var vulnerableCollectionView: UICollectionView = {
        Factory.makeCollectionView(superview: view)
    }()
    
    //MARK: -- Properties
    
    private var animalData: [Species] = [] {
        didSet {
            filteredCriticalSpecies = filterSpecies(by: .critical)
            filteredEndangeredSpecies = filterSpecies(by: .endangered)
            filteredVulnerableSpecies = filterSpecies(by: .vulnerable)
        }
    }
    
    private var filteredCriticalSpecies = [Species]() {
        didSet {
            criticalCollectionView.reloadData()
        }
    }
    
    private var filteredEndangeredSpecies = [Species]() {
        didSet {
            endangeredCollectionView.reloadData()
        }
    }
    
    private var filteredVulnerableSpecies = [Species]() {
        didSet {
            vulnerableCollectionView.reloadData()
        }
    }
    
    //MARK: -- Methods
    
    func showModally(_ viewController: UIViewController) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let rootViewController = window?.rootViewController
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    private func filterSpecies(by status: ConservationStatus) -> [Species] {
        let filteredSpecies = animalData.filter { $0.population.conservationStatus == status }
        return filteredSpecies
    }
    
    private func loadSpeciesDataFromFirebase() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            FirestoreService.manager.getAllSpeciesData() { (result) in
                
                switch result {
                case .success(let speciesData):
                    self.animalData = speciesData
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setDatasourceAndDelegates() {
        let collectionViews = [criticalCollectionView, endangeredCollectionView, vulnerableCollectionView]
        collectionViews.forEach { $0.dataSource = self }
        collectionViews.forEach { $0.delegate = self }
        scrollView.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollViewConstraints()
        scrollView.updateContentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = #colorLiteral(red: 0.0744978413, green: 0.0745158717, blue: 0.07449541241, alpha: 1)
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
        loadSpeciesDataFromFirebase()
        setDatasourceAndDelegates()
    }
}

//MARK: -- CollectionView DataSource Methods
extension SpeciesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case criticalCollectionView: return filteredCriticalSpecies.count
        case endangeredCollectionView: return filteredEndangeredSpecies.count
        case vulnerableCollectionView: return filteredVulnerableSpecies.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let speciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
        
        switch collectionView {
        case criticalCollectionView:
            let specificAnimal = filteredCriticalSpecies[indexPath.row]
            speciesCell.configureCellUI(from: specificAnimal)
            return speciesCell
            
        case endangeredCollectionView:
            let specificAnimal = filteredEndangeredSpecies[indexPath.row]
            speciesCell.configureCellUI(from: specificAnimal)
            return speciesCell
            
        case vulnerableCollectionView:
            let specificAnimal = filteredVulnerableSpecies[indexPath.row]
            speciesCell.configureCellUI(from: specificAnimal)
            return speciesCell
            
        default: return UICollectionViewCell()
        }
    }
}

//MARK: -- CollectionView Delegate Methods
extension SpeciesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 290, height: 230)
        return CGSize(width: 240, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var specificAnimal = Species(fromFirebaseDict: [:])
        
        switch collectionView {
        case criticalCollectionView: specificAnimal = filteredCriticalSpecies[indexPath.row]
            
        case endangeredCollectionView: specificAnimal = filteredEndangeredSpecies[indexPath.row]
            
        case vulnerableCollectionView: specificAnimal = filteredVulnerableSpecies[indexPath.row]
            
        default: ()
        }
        
        let detailVC = SpeciesDetailViewController()
        detailVC.currentSpecies = specificAnimal
        
        showModally(detailVC)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.universalLeadingConstant
    }
}

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesListViewController {
    
    func addSubviews() {
        let mainViewUIElements = [terraTitleLabel, subtitleLabel, scrollView]
        mainViewUIElements.forEach { view.addSubview($0) }
        mainViewUIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let scrollViewUIElements = [criticalSpeciesLabel, criticalCollectionView, endangeredSpeciesLabel, endangeredCollectionView, vulnerableSpeciesLabel, vulnerableCollectionView]
        scrollViewUIElements.forEach{ scrollView.addSubview($0) }
        scrollViewUIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setTerraTitleLabelConstraints()
        setSubtitleLabelConstraints()
        
        setCriticalSpeciesLabelConstraints()
        setCriticalSpeciesCVConstraints()
        
        setEndangeredSpeciesLabelConstraints()
        setEndangeredSpeciesCVConstraints()
        
        setVulnerableSpeciesLabelConstraints()
        setVulnerableSpeciesCVConstraints()
    }
    
    func setScrollViewConstraints(){
        scrollView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }
    
    func setBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor)
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
            terraTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            terraTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            terraTitleLabel.heightAnchor.constraint(equalToConstant: 25),
            terraTitleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setSubtitleLabelConstraints() {
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: terraTitleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: terraTitleLabel.leadingAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 20),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setCriticalSpeciesLabelConstraints() {
        NSLayoutConstraint.activate([
            criticalSpeciesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            criticalSpeciesLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            criticalSpeciesLabel.heightAnchor.constraint(equalToConstant: 30),
            criticalSpeciesLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setCriticalSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            criticalCollectionView.topAnchor.constraint(equalTo: criticalSpeciesLabel.bottomAnchor, constant: 20),
            criticalCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            criticalCollectionView.heightAnchor.constraint(equalToConstant: Constants.listVCCollectionViewHeight)
        ])
    }
    
    func setEndangeredSpeciesLabelConstraints() {
        NSLayoutConstraint.activate([
            endangeredSpeciesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            endangeredSpeciesLabel.topAnchor.constraint(equalTo: criticalCollectionView.bottomAnchor, constant: 30),
            endangeredSpeciesLabel.heightAnchor.constraint(equalToConstant: 30),
            endangeredSpeciesLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setEndangeredSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            endangeredCollectionView.topAnchor.constraint(equalTo: endangeredSpeciesLabel.bottomAnchor, constant: 20),
            endangeredCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            endangeredCollectionView.heightAnchor.constraint(equalToConstant: Constants.listVCCollectionViewHeight),
            endangeredCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    func setVulnerableSpeciesLabelConstraints() {
        NSLayoutConstraint.activate([
            vulnerableSpeciesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            vulnerableSpeciesLabel.topAnchor.constraint(equalTo: endangeredCollectionView.bottomAnchor, constant: 30),
            vulnerableSpeciesLabel.heightAnchor.constraint(equalToConstant: 30),
            vulnerableSpeciesLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setVulnerableSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            vulnerableCollectionView.topAnchor.constraint(equalTo: vulnerableSpeciesLabel.bottomAnchor, constant: 20),
            vulnerableCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            vulnerableCollectionView.heightAnchor.constraint(equalToConstant: Constants.listVCCollectionViewHeight),
            vulnerableCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
}

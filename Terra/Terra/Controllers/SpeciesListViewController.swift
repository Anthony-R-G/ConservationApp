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
    
    private lazy var terraTitleLabel: UILabel = {
        let label = Utilities.makeLabel(title: "Terra", weight: .bold, size: 30, alignment: .left)
        label.textColor = #colorLiteral(red: 0.9257398248, green: 1, blue: 0.7623538375, alpha: 1)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = Utilities.makeLabel(title: "Protect the earth's biodiversity",
                                        weight: .light,
                                        size: 20,
                                        alignment: .left)
        label.textColor = #colorLiteral(red: 0.6699403524, green: 0.6602986455, blue: 0.7864833474, alpha: 1)
        return label
    }()
    
    private lazy var criticalSpeciesLabel: UILabel = {
        let label = Utilities.makeLabel(title: "CRITICALLY ENDANGERED", weight: .medium, size: 19, alignment: .left)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7993899829)
        return label
    }()
    
    private lazy var endangeredSpeciesLabel: UILabel = {
        let label = Utilities.makeLabel(title: "ENDANGERED", weight: .medium, size: 19, alignment: .left)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7993899829)
        return label
    }()
    
    private lazy var vulnerableSpeciesLabel: UILabel = {
        let label = Utilities.makeLabel(title: "VULNERABLE", weight: .medium, size: 19, alignment: .left)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7993899829)
        return label
    }()
    
    private lazy var criticalCollectionView: UICollectionView = {
        Utilities.makeCollectionView(superView: self.view)
    }()
    
    private lazy var endangeredCollectionView: UICollectionView = {
        Utilities.makeCollectionView(superView: self.view)
    }()
    
    private lazy var vulnerableCollectionView: UICollectionView = {
        Utilities.makeCollectionView(superView: self.view)
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
    
    private func filterSpecies(by status: ConservationStatus) -> [Species] {
        let filteredSpecies = animalData.filter { $0.conservationStatus == status }
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
                    print(error.localizedDescription)
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
        view.backgroundColor = #colorLiteral(red: 0.1046695188, green: 0.09944508225, blue: 0.2029559612, alpha: 1)
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
        return CGSize(width: 290, height: 230)
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
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

//MARK: -- Adding Subviews & Constraints
extension SpeciesListViewController {
    
    private func addSubviews() {
        let mainViewUIElements = [terraTitleLabel, subtitleLabel, scrollView]
        mainViewUIElements.forEach { view.addSubview($0) }
        mainViewUIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let scrollViewUIElements = [criticalSpeciesLabel, criticalCollectionView, endangeredSpeciesLabel, endangeredCollectionView, vulnerableSpeciesLabel, vulnerableCollectionView]
        scrollViewUIElements.forEach{ scrollView.addSubview($0) }
        scrollViewUIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
        setTerraTitleLabelConstraints()
        setSubtitleLabelConstraints()
        
        setCriticalSpeciesLabelConstraints()
        setCriticalSpeciesCVConstraints()
        
        setEndangeredSpeciesLabelConstraints()
        setEndangeredSpeciesCVConstraints()
        
        setVulnerableSpeciesLabelConstraints()
        setVulnerableSpeciesCVConstraints()
    }
    
    private func setScrollViewConstraints(){
        scrollView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setTerraTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            terraTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            terraTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            terraTitleLabel.heightAnchor.constraint(equalToConstant: 25),
            terraTitleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setSubtitleLabelConstraints() {
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: terraTitleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: terraTitleLabel.leadingAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 20),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setCriticalSpeciesLabelConstraints() {
        NSLayoutConstraint.activate([
            criticalSpeciesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            criticalSpeciesLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            criticalSpeciesLabel.heightAnchor.constraint(equalToConstant: 30),
            criticalSpeciesLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setCriticalSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            criticalCollectionView.topAnchor.constraint(equalTo: criticalSpeciesLabel.bottomAnchor, constant: 30),
            criticalCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            criticalCollectionView.heightAnchor.constraint(equalToConstant: Constants.listVCCollectionViewHeight)
        ])
    }
    
    private func setEndangeredSpeciesLabelConstraints() {
        NSLayoutConstraint.activate([
            endangeredSpeciesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            endangeredSpeciesLabel.topAnchor.constraint(equalTo: criticalCollectionView.bottomAnchor, constant: 30),
            endangeredSpeciesLabel.heightAnchor.constraint(equalToConstant: 30),
            endangeredSpeciesLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setEndangeredSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            endangeredCollectionView.topAnchor.constraint(equalTo: endangeredSpeciesLabel.bottomAnchor, constant: 30),
            endangeredCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            endangeredCollectionView.heightAnchor.constraint(equalToConstant: Constants.listVCCollectionViewHeight),
            endangeredCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    private func setVulnerableSpeciesLabelConstraints() {
        NSLayoutConstraint.activate([
            vulnerableSpeciesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            vulnerableSpeciesLabel.topAnchor.constraint(equalTo: endangeredCollectionView.bottomAnchor, constant: 30),
            vulnerableSpeciesLabel.heightAnchor.constraint(equalToConstant: 30),
            vulnerableSpeciesLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setVulnerableSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            vulnerableCollectionView.topAnchor.constraint(equalTo: vulnerableSpeciesLabel.bottomAnchor, constant: 30),
            vulnerableCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            vulnerableCollectionView.heightAnchor.constraint(equalToConstant: Constants.listVCCollectionViewHeight),
            vulnerableCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
}

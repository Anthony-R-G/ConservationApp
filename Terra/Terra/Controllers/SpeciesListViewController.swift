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
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var terraTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Terra"
        label.font = UIFont(name: "Roboto-Bold", size: 30)
        label.textColor = #colorLiteral(red: 0.9257398248, green: 1, blue: 0.7623538375, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Protect the earth's biodiversity"
        label.font = UIFont(name: "Roboto-Light", size: 20)
        label.textColor = #colorLiteral(red: 0.6699403524, green: 0.6602986455, blue: 0.7864833474, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var criticalSpeciesLabel: UILabel = {
        let label = UILabel()
        label.text = "CRITICALLY ENDANGERED"
        label.font = UIFont(name: "Roboto-Medium", size: 19)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7993899829)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var vulnerableSpeciesLabel: UILabel = {
        let label = UILabel()
        label.text = "VULNERABLE"
        label.font = UIFont(name: "Roboto-Medium", size: 19)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7993899829)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var endangeredSpeciesLabel: UILabel = {
        let label = UILabel()
        label.text = "ENDANGERED"
        label.font = UIFont(name: "Roboto-Medium", size: 21)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7993899829)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var criticalSpeciesCollectionView: UICollectionView = {
        Utilities.makeCollectionView(superView: self.view)
    }()
    
    private lazy var endangeredSpeciesCollectionView: UICollectionView = {
        Utilities.makeCollectionView(superView: self.view)
    }()
    
    private lazy var vulnerableSpeciesCollectionView: UICollectionView = {
        Utilities.makeCollectionView(superView: self.view)
    }()
    
    //MARK: -- Properties
    
    private var animalData = [Species]() {
        didSet {
            filteredCriticalSpecies = filterSpecies(by: .critical)
            filteredEndangeredSpecies = filterSpecies(by: .endangered)
            filteredVulnerableSpecies = filterSpecies(by: .vulnerable)
        }
    }
    
    private var filteredCriticalSpecies = [Species]() {
        didSet {
            criticalSpeciesCollectionView.reloadData()
        }
    }
    
    private var filteredEndangeredSpecies = [Species]() {
        didSet {
            endangeredSpeciesCollectionView.reloadData()
        }
    }
    
    private var filteredVulnerableSpecies = [Species]() {
        didSet {
            vulnerableSpeciesCollectionView.reloadData()
        }
    }
    
    //MARK: -- Methods
    
    private func filterSpecies(by status: ConservationStatus) -> [Species] {
        let filteredSpecies = animalData.filter { $0.conservationStatus == status }
        return filteredSpecies
    }
    
    private func loadSpeciesDataFromFirebase() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            FirestoreService.manager.getAllSpeciesData() { (result) in
                
                switch result {
                case .success(let speciesData):
                    self?.animalData = speciesData
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func setDatasourceAndDelegates() {
        let collectionViews = [criticalSpeciesCollectionView, endangeredSpeciesCollectionView, vulnerableSpeciesCollectionView]
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
        case criticalSpeciesCollectionView: return filteredCriticalSpecies.count
        case endangeredSpeciesCollectionView: return filteredEndangeredSpecies.count
        case vulnerableSpeciesCollectionView: return filteredVulnerableSpecies.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let speciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
        
        switch collectionView {
        case criticalSpeciesCollectionView:
            let specificAnimal = filteredCriticalSpecies[indexPath.row]
            speciesCell.configureCellUI(from: specificAnimal)
            return speciesCell
            
        case endangeredSpeciesCollectionView:
            let specificAnimal = filteredEndangeredSpecies[indexPath.row]
            speciesCell.configureCellUI(from: specificAnimal)
            return speciesCell
            
        case vulnerableSpeciesCollectionView:
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
        var specificAnimal = Species(from: [:])
        
        switch collectionView {
        case criticalSpeciesCollectionView: specificAnimal = filteredCriticalSpecies[indexPath.row]
            
        case endangeredSpeciesCollectionView: specificAnimal = filteredEndangeredSpecies[indexPath.row]
            
        case vulnerableSpeciesCollectionView: specificAnimal = filteredVulnerableSpecies[indexPath.row]
            
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
        
        let scrollViewUIElements = [criticalSpeciesLabel, criticalSpeciesCollectionView, endangeredSpeciesLabel, endangeredSpeciesCollectionView, vulnerableSpeciesLabel, vulnerableSpeciesCollectionView]
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
            criticalSpeciesCollectionView.topAnchor.constraint(equalTo: criticalSpeciesLabel.bottomAnchor, constant: 30),
            criticalSpeciesCollectionView.heightAnchor.constraint(equalToConstant: Constants.listVCCollectionViewHeight),
            criticalSpeciesCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setEndangeredSpeciesLabelConstraints() {
        NSLayoutConstraint.activate([
            endangeredSpeciesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            endangeredSpeciesLabel.topAnchor.constraint(equalTo: criticalSpeciesCollectionView.bottomAnchor, constant: 30),
            endangeredSpeciesLabel.heightAnchor.constraint(equalToConstant: 30),
            endangeredSpeciesLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setEndangeredSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            endangeredSpeciesCollectionView.topAnchor.constraint(equalTo: endangeredSpeciesLabel.bottomAnchor, constant: 30),
            endangeredSpeciesCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            endangeredSpeciesCollectionView.heightAnchor.constraint(equalToConstant: 235),
            endangeredSpeciesCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    private func setVulnerableSpeciesLabelConstraints() {
        NSLayoutConstraint.activate([
            vulnerableSpeciesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            vulnerableSpeciesLabel.topAnchor.constraint(equalTo: endangeredSpeciesCollectionView.bottomAnchor, constant: 30),
            vulnerableSpeciesLabel.heightAnchor.constraint(equalToConstant: 30),
            vulnerableSpeciesLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setVulnerableSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            vulnerableSpeciesCollectionView.topAnchor.constraint(equalTo: vulnerableSpeciesLabel.bottomAnchor, constant: 30),
            vulnerableSpeciesCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            vulnerableSpeciesCollectionView.heightAnchor.constraint(equalToConstant: 235),
            vulnerableSpeciesCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
}

//
//  SpeciesListViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class SpeciesListViewController: UIViewController {
    
    lazy var terraTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Terra"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Protect the earth's biodiversity"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.6699403524, green: 0.6602986455, blue: 0.7864833474, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    lazy var criticalSpeciesCV: UICollectionView = {
        Utilities.makeCollectionView(parentView: self.view)
    }()
    
    lazy var endangeredSpeciesCV: UICollectionView = {
        Utilities.makeCollectionView(parentView: self.view)
    }()
    
    lazy var vulnerableSpeciesCV: UICollectionView = {
        Utilities.makeCollectionView(parentView: self.view)
    }()
    
    
    var animalData = [Species]() {
        didSet {
            filteredCriticalSpecies = filterSpecies(by: .critical)
            criticalSpeciesCV.reloadData()
        }
    }
    
    var filteredCriticalSpecies = [Species]()
    
    var filteredEndangeredSpecies = [Species]()
    
    var filteredVulnerableSpecies = [Species]()
    
    
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
        let collectionViews = [criticalSpeciesCV, endangeredSpeciesCV, vulnerableSpeciesCV]
        collectionViews.forEach { $0.dataSource = self }
        collectionViews.forEach { $0.delegate = self }
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1046695188, green: 0.09944508225, blue: 0.2029559612, alpha: 1)
        setConstraints()
        loadSpeciesDataFromFirebase()
        setDatasourceAndDelegates()
    }
}

//MARK: -- Constraints
extension SpeciesListViewController {
    private func setConstraints(){
        let UIElements = [terraTitleLabel, subtitleLabel, criticalSpeciesCV]
        UIElements.forEach{ view.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        setTerraTitleLabelConstraints()
        setSubtitleLabelConstraints()
        setCriticalSpeciesCVConstraints()
    }
    
    private func setTerraTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            terraTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            terraTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
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
    
    private func setCriticalSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            criticalSpeciesCV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            criticalSpeciesCV.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            criticalSpeciesCV.widthAnchor.constraint(equalTo: view.widthAnchor),
            criticalSpeciesCV.heightAnchor.constraint(equalToConstant: 310)
        ])
    }
}

//MARK: -- CollectionView Methods
extension SpeciesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCriticalSpecies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let speciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
        
        let specificAnimal = filteredCriticalSpecies[indexPath.row]
        speciesCell.configureCell(from: specificAnimal)
        return speciesCell
    }
}
 
extension SpeciesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let specificAnimal = filteredCriticalSpecies[indexPath.row]
        let detailVC = SpeciesDetailViewController()
        detailVC.currentSpecies = specificAnimal
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

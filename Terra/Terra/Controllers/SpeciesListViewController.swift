//
//  SpeciesListViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class SpeciesListViewController: UIViewController {
    
    lazy var speciesCollectionView: UICollectionView = {
        Utilities.makeCollectionView(view: self.view)
    }()
    
    
    var animalData = [Species]() {
        didSet {
            filteredCriticalSpecies = filterSpecies(by: .critical)
            speciesCollectionView.reloadData()
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

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1046695188, green: 0.09944508225, blue: 0.2029559612, alpha: 1)
        setConstraints()
        loadSpeciesDataFromFirebase()
        speciesCollectionView.delegate = self
        speciesCollectionView.dataSource = self
    }
}

extension SpeciesListViewController {
    private func setConstraints(){
        [speciesCollectionView].forEach{view.addSubview($0)}
        [speciesCollectionView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        setSpeciesCollectionViewConstraints()
        
    }
    
    private func setSpeciesCollectionViewConstraints(){
        NSLayoutConstraint.activate([
            speciesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speciesCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            speciesCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            speciesCollectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
}

extension SpeciesListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCriticalSpecies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let speciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
        
        let specificAnimal = filteredCriticalSpecies[indexPath.row]
        speciesCell.configureCell(from: specificAnimal)
        return speciesCell
    }
    
    
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

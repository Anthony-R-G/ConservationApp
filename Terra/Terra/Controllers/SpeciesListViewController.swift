//
//  SpeciesListViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class SpeciesListViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    
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
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.6699403524, green: 0.6602986455, blue: 0.7864833474, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    lazy var criticalSpeciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Critically Endangered"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var vulnerableSpeciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Vulnerable"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .white
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
            filteredEndangeredSpecies = filterSpecies(by: .endangered)
            filteredVulnerableSpecies = filterSpecies(by: .vulnerable)
        }
    }
    
    var filteredCriticalSpecies = [Species]() {
        didSet {
            criticalSpeciesCV.reloadData()
        }
    }
    
    var filteredEndangeredSpecies = [Species]() {
        didSet {
            endangeredSpeciesCV.reloadData()
        }
    }
    
    var filteredVulnerableSpecies = [Species]() {
        didSet {
            vulnerableSpeciesCV.reloadData()
        }
    }
    
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollViewConstraints()
        setContentViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1046695188, green: 0.09944508225, blue: 0.2029559612, alpha: 1)
        setConstraints()
        loadSpeciesDataFromFirebase()
        setDatasourceAndDelegates()
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 600)
    }
}

//MARK: -- Constraints
extension SpeciesListViewController {
    private func setConstraints(){
        view.addSubview(terraTitleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        terraTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        let UIElements = [criticalSpeciesLabel, criticalSpeciesCV, vulnerableSpeciesLabel, vulnerableSpeciesCV]
        UIElements.forEach{ contentView.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        setTerraTitleLabelConstraints()
        setSubtitleLabelConstraints()
        setCriticalSpeciesLabelConstraints()
        setCriticalSpeciesCVConstraints()
        setVulnerableSpeciesLabelConstraints()
        setVulnerableSpeciesCVConstraints()
        
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
        criticalSpeciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
        criticalSpeciesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 30 ),
        criticalSpeciesLabel.heightAnchor.constraint(equalToConstant: 30),
        criticalSpeciesLabel.widthAnchor.constraint(equalToConstant: 300)
        
        ])
    }
    
    private func setCriticalSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            criticalSpeciesCV.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            criticalSpeciesCV.heightAnchor.constraint(equalToConstant: 235),
            criticalSpeciesCV.topAnchor.constraint(equalTo: criticalSpeciesLabel.bottomAnchor, constant: 30),
            criticalSpeciesCV.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
                    ])
        
    }
    
    private func setVulnerableSpeciesLabelConstraints() {
        NSLayoutConstraint.activate([
            vulnerableSpeciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            vulnerableSpeciesLabel.topAnchor.constraint(equalTo: criticalSpeciesCV.bottomAnchor, constant: 30),
            vulnerableSpeciesLabel.heightAnchor.constraint(equalToConstant: 30),
            criticalSpeciesLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setVulnerableSpeciesCVConstraints() {
        NSLayoutConstraint.activate([
            vulnerableSpeciesCV.topAnchor.constraint(equalTo: vulnerableSpeciesLabel.bottomAnchor, constant: 30),
            vulnerableSpeciesCV.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            vulnerableSpeciesCV.heightAnchor.constraint(equalToConstant: 235),
            vulnerableSpeciesCV.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setScrollViewConstraints(){
          scrollView.backgroundColor = .clear
          scrollView.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              scrollView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30),
              scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
          ])
      }
    
    private func setContentViewConstraints() {
           contentView.backgroundColor = .clear
           contentView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
               contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
               contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
               contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
           ])
       }
    
    
}

//MARK: -- CollectionView Methods
extension SpeciesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case criticalSpeciesCV: return filteredCriticalSpecies.count
        case vulnerableSpeciesCV: return filteredVulnerableSpecies.count
        default: return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let speciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
        
        switch collectionView {
            
        case criticalSpeciesCV:
            let specificAnimal = filteredCriticalSpecies[indexPath.row]
            speciesCell.configureCell(from: specificAnimal)
            return speciesCell
            
        case vulnerableSpeciesCV:
            let specificAnimal = filteredVulnerableSpecies[indexPath.row]
            speciesCell.configureCell(from: specificAnimal)
            return speciesCell
            
        default: return UICollectionViewCell()
            
        }
    }
}

extension SpeciesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 290, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var specificAnimal = Species(from: [:])
        
        switch collectionView {
        case criticalSpeciesCV: specificAnimal = filteredCriticalSpecies[indexPath.row]
            
        case vulnerableSpeciesCV: specificAnimal = filteredVulnerableSpecies[indexPath.row]
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

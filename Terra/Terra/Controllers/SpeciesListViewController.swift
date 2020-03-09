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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(SpeciesCollectionViewCell.self, forCellWithReuseIdentifier: "speciesCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    
    let animalData = Species.listTestData
    
    
     lazy var myView: UIView = UILabel()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1046695188, green: 0.09944508225, blue: 0.2029559612, alpha: 1)
        setConstraints()
        
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
        return animalData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let speciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
        let specificAnimal = animalData[indexPath.row]
      
        
        speciesCell.speciesNameLabel.text = specificAnimal.commonName
        speciesCell.speciesImage.image = specificAnimal.collectionViewImage
        
        return speciesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 390)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let specificAnimal = animalData[indexPath.row]
        let detailVC = SpeciesDetailViewController()
        detailVC.currentSpecies = specificAnimal
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

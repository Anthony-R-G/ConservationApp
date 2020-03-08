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
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0), collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.register(SpeciesCollectionViewCell.self, forCellWithReuseIdentifier: "speciesCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    
    var testData = ["Elephant", "Lion", "Gorilla", "XYZ"]
    var testImages: [UIImage] = [#imageLiteral(resourceName: "elephantCellImage"),#imageLiteral(resourceName: "lionCellImage"),#imageLiteral(resourceName: "gorillaCellImage"),#imageLiteral(resourceName: "leopardCellImage")]
     lazy var myView: UIView = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9988102317, green: 0.9860382676, blue: 0.9007986188, alpha: 1)
        setConstraints()
          print(self.view.frame)
        
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
            speciesCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            speciesCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            speciesCollectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
}

extension SpeciesListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let speciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
        let specificItem = testData[indexPath.row]
        let specificImage = testImages[indexPath.row]
        
        speciesCell.speciesNameLabel.text = specificItem
        speciesCell.speciesImage.image = specificImage 
        
        return speciesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 390)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let specificItem = testData[indexPath.row]
        
        print("You've selected \(specificItem) at row \(indexPath.row)")
    }
    
}

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
    
    private lazy var topToolBar: toolBar = {
        let tb = toolBar(frame: .zero, strategy: ToolBarListVCStrategy())
        return tb
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
    
    private lazy var speciesCollectionView: UICollectionView = {
        Factory.makeCollectionView()
    }()
    
    //MARK: -- Properties
    
    private var animalData: [Species] = [] {
        didSet {
            speciesCollectionView.reloadData()
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
        speciesCollectionView.dataSource = self
        speciesCollectionView.delegate = self
        topToolBar.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return animalData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let speciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
        let specificAnimal = animalData[indexPath.row]
        speciesCell.configureCellUI(from: specificAnimal)
        return speciesCell
    }
}

//MARK: -- CollectionView Delegate Methods
extension SpeciesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let specificAnimal = animalData[indexPath.row]
        
        let detailVC = SpeciesDetailViewController()
        detailVC.currentSpecies = specificAnimal
        
        showModally(detailVC)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//MARK: -- Custom Delegate Implementations
extension SpeciesListViewController: BottomBarDelegate {
    func buttonPressed(_ sender: UIButton) {
        guard let buttonOption = ButtonOption(rawValue: sender.tag) else { return }
        topToolBar.highlightButton(button: buttonOption)
        switch buttonOption {
        case .overviewButton:
            <#code#>
        case .habitatButton:
            <#code#>
        case .threatsButton:
            <#code#>
        case .galleryButton:
            <#code#>
        }
    }
    
    
}

//MARK: -- Add Subviews & Constraints

fileprivate extension SpeciesListViewController {
    
    func addSubviews() {
        let mainViewUIElements = [terraTitleLabel, speciesCollectionView, topToolBar]
        mainViewUIElements.forEach { view.addSubview($0) }
        mainViewUIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setBackgroundImageViewConstraints()
        setBackgroundGradientOverlayConstraints()
        
        setTerraTitleLabelConstraints()
        //        setSubtitleLabelConstraints()
        
        setSpeciesCollectionViewConstraints()
        setToolBarConstraints()
        
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
            terraTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            terraTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
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

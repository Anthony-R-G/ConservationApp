//
//  ViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices

class SpeciesDetailViewController: UIViewController {
    
    var currentSpecies: Species!
    
    var scrollView = UIScrollView(frame: UIScreen.main.bounds)
    var contentView = UIView()
    
    lazy var basicInfoView: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4877193921)
        return view
    }()
    
    lazy var conservationStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.backgroundColor = #colorLiteral(red: 0.6787196398, green: 0.2409698367, blue: 0.261569947, alpha: 0.8461579623)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    lazy var speciesCommonNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 55)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var speciesScientificNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var numbersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numbersLabel, numbersInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var numbersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Numbers"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var numbersInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
        
    }()
    
//    lazy var speciesPopulationNarrativeTextView: UITextView = {
//        let tv = UITextView()
//        tv.isEditable = false
//        tv.textColor = #colorLiteral(red: 0.3074202836, green: 0.3078328371, blue: 0.416093111, alpha: 1)
//        tv.backgroundColor = .clear
//
//        tv.textAlignment = .left
//        return tv
//    }()
    
    lazy var summaryTextView: UITextView = {
       let tv = UITextView()
        tv.isEditable = false
        tv.textColor = #colorLiteral(red: 0.3074202836, green: 0.3078328371, blue: 0.416093111, alpha: 1)
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.backgroundColor = .clear
        tv.textAlignment = .left
        
        return tv
    }()
    
    lazy var kingdomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kingdomLabel, kingdomInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var kingdomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Kingdom"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var kingdomInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    lazy var classStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [classLabel, classInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var classLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Class"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var classInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    lazy var familyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [familyLabel, familyInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var familyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Family"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var familyInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    lazy var phylumStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phylumLabel, phylumInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var phylumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Phylum"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var phylumInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    lazy var orderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [orderLabel, orderInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Order"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var orderInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    lazy var genusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genusLabel, genusInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var genusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Genus"
        label.textColor = #colorLiteral(red: 0.3479366601, green: 0.3600047827, blue: 0.429291755, alpha: 1)
        return label
    }()
    
    lazy var genusInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    lazy var summaryView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9025845462)
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    lazy var taxonomyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taxonomy"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    private func showWebBrowser(link: URL){
           let config = SFSafariViewController.Configuration()
           config.entersReaderIfAvailable = true
           let safariVC = SFSafariViewController(url: link, configuration: config)
           present(safariVC, animated: true)
       }
    
//    private func eventLinkButtonPressed(_ sender: UIButton) {
//         showWebBrowser(link: URL(string: currentSpecies.donationLink)!)
//    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setUpUIFromSpecies(){
        speciesCommonNameLabel.text = currentSpecies.commonName
        speciesScientificNameLabel.text = "— \(currentSpecies.scientificName)"
        summaryTextView.text = currentSpecies.habitat
        kingdomInfoLabel.text = currentSpecies.kingdom
        classInfoLabel.text = currentSpecies.classTaxonomy
        familyInfoLabel.text = currentSpecies.family
        phylumInfoLabel.text = currentSpecies.phylum
        orderInfoLabel.text = currentSpecies.order
        genusInfoLabel.text = currentSpecies.genus
        numbersInfoLabel.text = currentSpecies.populationNumbers
        conservationStatusLabel.text = currentSpecies.conservationStatus
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setUpUIFromSpecies()
        setConstraints()
        
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 600)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = currentSpecies.detailViewImage
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let backgroundOverlay = GradientView(frame: UIScreen.main.bounds)
        backgroundOverlay.startColor = .clear
        backgroundOverlay.endColor = #colorLiteral(red: 0.06859237701, green: 0.08213501424, blue: 0.2409383953, alpha: 0.8456228596)
        self.view.insertSubview(backgroundOverlay, at: 1)
        summaryView.layer.zPosition = 1
        basicInfoView.layer.zPosition = 0
   
    }
}


//MARK: -- Constraints
extension SpeciesDetailViewController {
    private func setConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [basicInfoView, summaryView].forEach{contentView.addSubview($0)}
        
        [basicInfoView, speciesCommonNameLabel, kingdomStackView, summaryView, summaryTitleLabel, speciesScientificNameLabel, taxonomyTitleLabel, classStackView, familyStackView, phylumStackView, orderStackView, genusStackView, conservationStatusLabel, numbersStackView, summaryTextView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        [speciesCommonNameLabel, speciesScientificNameLabel, conservationStatusLabel, numbersStackView].forEach{basicInfoView.addSubview($0)}
        
        [summaryTitleLabel, taxonomyTitleLabel, kingdomStackView, classStackView, familyStackView, phylumStackView, orderStackView, genusStackView, summaryTextView].forEach{summaryView.addSubview($0)}
        
        setSpeciesCommonNameLabelConstraints()
        setSummaryViewConstraints()
        setSummaryTextViewConstraints()
        setSummaryTitleLabelConstraints()
        setSpeciesScientificNameLabelConstraints()
        setTaxonomyTitleLabelConstraints()
        setKingdomStackViewConstraints()
        setClassStackViewConstraints()
        setFamilyStackViewConstraints()
        setPhylumStackViewConstraints()
        setOrderStackViewConstraints()
        setGenusStackViewConstraints()
        setConservationStatusLabelConstraints()
        setBasicInfoViewConstraints()
        setNumbersStackConstraints()
        
    }
    
    
    private func setBasicInfoViewConstraints() {
        NSLayoutConstraint.activate([
            basicInfoView.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor),
            basicInfoView.heightAnchor.constraint(equalToConstant: 400),
            basicInfoView.widthAnchor.constraint(equalToConstant: 380),
            basicInfoView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 150)
        ])
    }
    
    private func setSummaryTextViewConstraints(){
        NSLayoutConstraint.activate([
        summaryTextView.topAnchor.constraint(equalTo: summaryTitleLabel.bottomAnchor, constant: 10),
        summaryTextView.leadingAnchor.constraint(equalTo: summaryTitleLabel.leadingAnchor),
        summaryTextView.widthAnchor.constraint(equalToConstant: 300),
        summaryTextView.bottomAnchor.constraint(equalTo: taxonomyTitleLabel.topAnchor, constant: -20)
        ])
    }
    
    private func setConservationStatusLabelConstraints() {
        NSLayoutConstraint.activate([
            conservationStatusLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor),
            conservationStatusLabel.bottomAnchor.constraint(equalTo: speciesCommonNameLabel.topAnchor, constant: -10),
            conservationStatusLabel.heightAnchor.constraint(equalToConstant: 30),
            conservationStatusLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    
    private func setNumbersStackConstraints(){
        NSLayoutConstraint.activate([
            numbersStackView.topAnchor.constraint(equalTo: speciesScientificNameLabel.bottomAnchor, constant: 15),
            numbersStackView.leadingAnchor.constraint(equalTo: basicInfoView.leadingAnchor),
            numbersStackView.heightAnchor.constraint(equalToConstant: 50),
            numbersStackView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    private func setSummaryViewConstraints(){
        NSLayoutConstraint.activate([
            summaryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            summaryView.heightAnchor.constraint(equalToConstant: 700),
            summaryView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.97),
            summaryView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 700)
        ])
    }
    
    
    private func setSummaryTitleLabelConstraints(){
        NSLayoutConstraint.activate([
            summaryTitleLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 30),
            summaryTitleLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 40),
            summaryTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            summaryTitleLabel.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    
    private func setTaxonomyTitleLabelConstraints(){
        NSLayoutConstraint.activate([
            taxonomyTitleLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 30),
            taxonomyTitleLabel.centerYAnchor.constraint(equalTo: summaryView.centerYAnchor),
            taxonomyTitleLabel.heightAnchor.constraint(equalTo: summaryTitleLabel.heightAnchor),
            taxonomyTitleLabel.widthAnchor.constraint(equalTo: summaryTitleLabel.widthAnchor)
        ])
    }
    
    
    private func setSpeciesCommonNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesCommonNameLabel.leadingAnchor.constraint(equalTo: basicInfoView.leadingAnchor),
            speciesCommonNameLabel.centerYAnchor.constraint(equalTo: basicInfoView.centerYAnchor, constant: 0),
            speciesCommonNameLabel.widthAnchor.constraint(equalToConstant: 300),
            speciesCommonNameLabel.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    
    private func setSpeciesScientificNameLabelConstraints() {
        NSLayoutConstraint.activate([
            speciesScientificNameLabel.topAnchor.constraint(equalTo: speciesCommonNameLabel.bottomAnchor),
            speciesScientificNameLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor),
            speciesScientificNameLabel.heightAnchor.constraint(equalToConstant: 30),
            speciesScientificNameLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
//    private func setSpeciesPopulationTextViewConstraints(){
//        NSLayoutConstraint.activate([
//            speciesPopulationNarrativeTextView.leadingAnchor.constraint(equalTo: summaryTitleLabel.leadingAnchor),
//            speciesPopulationNarrativeTextView.topAnchor.constraint(equalTo: summaryTitleLabel.bottomAnchor, constant: 20),
//            speciesPopulationNarrativeTextView.heightAnchor.constraint(equalToConstant: 170),
//            speciesPopulationNarrativeTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//        ])
//    }
    
    
    private func setKingdomStackViewConstraints(){
        NSLayoutConstraint.activate([
            kingdomStackView.leadingAnchor.constraint(equalTo: summaryTitleLabel.leadingAnchor),
            kingdomStackView.topAnchor.constraint(equalTo: taxonomyTitleLabel.bottomAnchor, constant: 30),
            kingdomStackView.heightAnchor.constraint(equalToConstant: 50),
            kingdomStackView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    private func setClassStackViewConstraints(){
        NSLayoutConstraint.activate([
            classStackView.leadingAnchor.constraint(equalTo: kingdomStackView.leadingAnchor),
            classStackView.topAnchor.constraint(equalTo: kingdomStackView.bottomAnchor, constant: 20),
            classStackView.heightAnchor.constraint(equalTo: kingdomStackView.heightAnchor),
            classStackView.widthAnchor.constraint(equalTo: kingdomStackView.widthAnchor)
        ])
    }
    
    
    private func setFamilyStackViewConstraints(){
        NSLayoutConstraint.activate([
            familyStackView.leadingAnchor.constraint(equalTo: kingdomStackView.leadingAnchor),
            familyStackView.topAnchor.constraint(equalTo: classStackView.bottomAnchor, constant: 20),
            familyStackView.heightAnchor.constraint(equalTo: kingdomStackView.heightAnchor),
            familyStackView.widthAnchor.constraint(equalTo: kingdomStackView.widthAnchor)
        ])
    }
    
    
    private func setPhylumStackViewConstraints(){
        NSLayoutConstraint.activate([
            phylumStackView.leadingAnchor.constraint(equalTo: kingdomStackView.trailingAnchor, constant: 50),
            phylumStackView.topAnchor.constraint(equalTo: kingdomStackView.topAnchor),
            phylumStackView.heightAnchor.constraint(equalTo: kingdomStackView.heightAnchor),
            phylumStackView.widthAnchor.constraint(equalTo: kingdomStackView.widthAnchor)
        ])
    }
    
    
    private func setOrderStackViewConstraints(){
        NSLayoutConstraint.activate([
            orderStackView.leadingAnchor.constraint(equalTo: phylumStackView.leadingAnchor),
            orderStackView.topAnchor.constraint(equalTo: classStackView.topAnchor),
            orderStackView.heightAnchor.constraint(equalTo: kingdomStackView.heightAnchor),
            orderStackView.widthAnchor.constraint(equalTo: kingdomStackView.widthAnchor)
        ])
    }
    
    
    private func setGenusStackViewConstraints(){
        NSLayoutConstraint.activate([
            genusStackView.leadingAnchor.constraint(equalTo: phylumStackView.leadingAnchor),
            genusStackView.topAnchor.constraint(equalTo: familyStackView.topAnchor),
            genusStackView.heightAnchor.constraint(equalTo: kingdomStackView.heightAnchor),
            genusStackView.widthAnchor.constraint(equalTo: kingdomStackView.widthAnchor)
        ])
    }
    
    
    private func setScrollViewConstraints(){
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollViewConstraints()
        setContentViewConstraints()
    }
}


extension SpeciesDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        //        if(offset > 500){
        //            print(offset)
        //            self.basicInfoView.frame = CGRect(x: 0, y: offset , width: self.view.bounds.size.width, height: 100)
        //        }else{
        //            self.basicInfoView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 100)
        //        }
        print(offset)
        if offset >= 350 {
            print("Pin it now")
            self.basicInfoView.frame = CGRect(x: 50, y: offset - 50, width: self.basicInfoView.bounds.size.width, height: self.basicInfoView.bounds.size.height)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
}

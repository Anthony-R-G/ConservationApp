//
//  ViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 1/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class SpeciesDetailViewController: UIViewController {
    
    var currentSpecies: SpeciesInfo!
    var currentSpeciesNarrative: SpeciesNarrative!
    
    
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
        label.text = "- Loxodonta africana"
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    
    lazy var speciesPopulationNarrativeTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.backgroundColor = .clear
        tv.textColor = #colorLiteral(red: 0.3074202836, green: 0.3078328371, blue: 0.416093111, alpha: 1)
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
        label.text = "Mammalia"
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
        label.text = "Elephantidae"
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
        label.text = "Chordata"
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
        label.text = "Proboscidea"
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
        label.text = "Loxodonta"
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
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    lazy var taxonomyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taxonomy"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textColor = #colorLiteral(red: 0.006244339049, green: 0, blue: 0.1978868842, alpha: 1)
        return label
    }()
    
    
    
    
    
    private func setUpUI(){
        speciesCommonNameLabel.text = currentSpecies.main_common_name
        speciesPopulationNarrativeTextView.text = currentSpeciesNarrative.population.withoutHtml
        kingdomInfoLabel.text = currentSpecies.kingdom
        setConstraints()
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var scrollView = UIScrollView(frame: UIScreen.main.bounds)
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        currentSpecies = SpeciesInfo.elephantTestInfo
        currentSpeciesNarrative = SpeciesNarrative.elephantTestInfo
        setUpUI()
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 600)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "elephantDetailVC")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}


//MARK: -- Constraints
extension SpeciesDetailViewController {
    private func setConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [speciesCommonNameLabel, speciesScientificNameLabel ,kingdomLabel, kingdomInfoLabel, summaryView].forEach{contentView.addSubview($0)}
        
        [speciesCommonNameLabel, speciesPopulationNarrativeTextView, kingdomStackView, summaryView, summaryTitleLabel, speciesScientificNameLabel, taxonomyTitleLabel, classStackView, familyStackView, phylumStackView, orderStackView, genusStackView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        [summaryTitleLabel, speciesPopulationNarrativeTextView, taxonomyTitleLabel, kingdomStackView, classStackView, familyStackView, phylumStackView, orderStackView, genusStackView].forEach{summaryView.addSubview($0)}
        
        setSpeciesCommonNameLabelConstraints()
        setSpeciesPopulationTextViewConstraints()
        setSummaryViewConstraints()
        setSummaryTitleLabelConstraints()
        setSpeciesScientificNameLabelConstraints()
        setTaxonomyTitleLabelConstraints()
        setKingdomStackViewConstraints()
        setClassStackViewConstraints()
        setFamilyStackViewConstraints()
        setPhylumStackViewConstraints()
        setOrderStackViewConstraints()
        setGenusStackViewConstraints()
    }
    
    private func setSummaryViewConstraints(){
        NSLayoutConstraint.activate([
            summaryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            summaryView.heightAnchor.constraint(equalToConstant: 700),
            summaryView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.97),
            summaryView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 630)
        ])
    }
    
    private func setSummaryTitleLabelConstraints(){
        NSLayoutConstraint.activate([
            summaryTitleLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 30),
            summaryTitleLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 15),
            summaryTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            summaryTitleLabel.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func setTaxonomyTitleLabelConstraints(){
        NSLayoutConstraint.activate([
            taxonomyTitleLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 30),
            taxonomyTitleLabel.topAnchor.constraint(equalTo: speciesPopulationNarrativeTextView.bottomAnchor, constant: 30),
            taxonomyTitleLabel.heightAnchor.constraint(equalTo: summaryTitleLabel.heightAnchor),
            taxonomyTitleLabel.widthAnchor.constraint(equalTo: summaryTitleLabel.widthAnchor)
        ])
    }
    
    private func setSpeciesCommonNameLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesCommonNameLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor),
            speciesCommonNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
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
    
    private func setSpeciesPopulationTextViewConstraints(){
        NSLayoutConstraint.activate([
            speciesPopulationNarrativeTextView.leadingAnchor.constraint(equalTo: summaryTitleLabel.leadingAnchor),
            speciesPopulationNarrativeTextView.topAnchor.constraint(equalTo: summaryTitleLabel.bottomAnchor, constant: 25),
            speciesPopulationNarrativeTextView.heightAnchor.constraint(equalToConstant: 170),
            speciesPopulationNarrativeTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
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
    
    
    private func configureScrollViewConstraints(){
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureContentViewConstraints() {
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
        configureScrollViewConstraints()
        configureContentViewConstraints()
    }
}


extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
}

extension SpeciesDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let scale = min(max(1.0 - offset / 200.0, 0.7), 1.0)
        speciesCommonNameLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}

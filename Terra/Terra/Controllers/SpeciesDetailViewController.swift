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
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    lazy var speciesImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "elephantDetailVC")
        return iv
    }()
    
    lazy var speciesPopulationNarrativeTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.backgroundColor = #colorLiteral(red: 0.9988102317, green: 0.9860382676, blue: 0.9007986188, alpha: 1)
        return tv
    }()
    
    lazy var kingdomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Kingdom"
        return label
    }()
    
    lazy var kingdomInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Species"
        return label
    }()
    
    lazy var speciesInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private func setUpUI(){
        speciesCommonNameLabel.text = currentSpecies.main_common_name
        speciesPopulationNarrativeTextView.text = currentSpeciesNarrative.population.withoutHtml
        kingdomInfoLabel.text = currentSpecies.kingdom
        speciesInfoLabel.text = currentSpecies.scientific_name
        setConstraints()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var scrollView = UIScrollView(frame: UIScreen.main.bounds)
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9988102317, green: 0.9860382676, blue: 0.9007986188, alpha: 1)
        currentSpecies = SpeciesInfo.elephantTestInfo
        currentSpeciesNarrative = SpeciesNarrative.elephantTestInfo
        setUpUI()
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 300)
    }
}

extension SpeciesDetailViewController {
    private func setConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        
        [speciesCommonNameLabel, speciesImage, speciesPopulationNarrativeTextView, kingdomLabel, kingdomInfoLabel, speciesLabel, speciesInfoLabel].forEach{contentView.addSubview($0)}
        
        [speciesCommonNameLabel, speciesImage, speciesPopulationNarrativeTextView, kingdomLabel, kingdomInfoLabel, speciesLabel, speciesInfoLabel].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        setSpeciesCommonNameLabel()
        setSpeciesImageConstraints()
        setSpeciesPopulationTextViewConstraints()
        setKingdomLabelConstraints()
        setKingdomInfoLabelConstraints()
        setSpeciesLabelConstraints()
        setSpeciesInfoLabelConstraints()
    }
    
    private func setSpeciesCommonNameLabel(){
        NSLayoutConstraint.activate([
            speciesCommonNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -45),
            speciesCommonNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -70),
        ])
    }
    
    private func setSpeciesImageConstraints(){
        NSLayoutConstraint.activate([
            speciesImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            speciesImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            speciesImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            speciesImage.heightAnchor.constraint(equalToConstant: 330)
        ])
    }
    
    private func setSpeciesPopulationTextViewConstraints(){
        NSLayoutConstraint.activate([
            speciesPopulationNarrativeTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            speciesPopulationNarrativeTextView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 300),
            speciesPopulationNarrativeTextView.heightAnchor.constraint(equalToConstant: 400),
            speciesPopulationNarrativeTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setKingdomLabelConstraints(){
        NSLayoutConstraint.activate([
            kingdomLabel.leadingAnchor.constraint(equalTo: speciesCommonNameLabel.leadingAnchor),
            kingdomLabel.topAnchor.constraint(equalTo: speciesCommonNameLabel.bottomAnchor, constant: 30),
            kingdomLabel.widthAnchor.constraint(equalToConstant: 100),
            kingdomLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setKingdomInfoLabelConstraints(){
        NSLayoutConstraint.activate([
            kingdomInfoLabel.leadingAnchor.constraint(equalTo: kingdomLabel.leadingAnchor),
            kingdomInfoLabel.topAnchor.constraint(equalTo: kingdomLabel.bottomAnchor, constant: 5),
            kingdomInfoLabel.widthAnchor.constraint(equalToConstant: 100),
            kingdomInfoLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setSpeciesLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesLabel.leadingAnchor.constraint(equalTo: kingdomLabel.trailingAnchor, constant: 40),
            speciesLabel.topAnchor.constraint(equalTo: kingdomLabel.topAnchor),
            speciesLabel.widthAnchor.constraint(equalToConstant: 100),
            speciesLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setSpeciesInfoLabelConstraints(){
        NSLayoutConstraint.activate([
            speciesInfoLabel.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor),
            speciesInfoLabel.topAnchor.constraint(equalTo: kingdomInfoLabel.topAnchor),
            speciesInfoLabel.widthAnchor.constraint(equalToConstant: 150),
            speciesInfoLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureScrollViewConstraints(){
         scrollView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }
     
     private func configureContentViewConstraints() {
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
           let scale = min(max(1.0 - offset / 200.0, 0.0), 1.0)
           speciesCommonNameLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
       }
}

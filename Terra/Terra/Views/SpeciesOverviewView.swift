//
//  SpeciesOverviewView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/20/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class SpeciesOverviewView: UIView {
    //MARK: -- UI Element Initialization
    private lazy var overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "TAXONOMY"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private lazy var summaryTextView: UITextView = {
        let tv = UITextView()
        tv.
        return tv
    }()
    
    
    //MARK: -- Methods
    public func setViewElementsFromSpeciesData(species: Species) {
        summaryTextView.text = species.populationSummary
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.addBlurToView()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: -- Adding Subviews & Constraints
extension SpeciesOverviewView {
    
    private func addSubviews() {
        let UIElements =  [overviewTitleLabel, summaryTextView]
        
        UIElements.forEach{ self.addSubview($0) }
        UIElements.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setConstraints() {
    }
    
    
}


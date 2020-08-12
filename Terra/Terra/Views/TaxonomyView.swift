//
//  TaxonomyView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class TaxonomyView: UIView {
    private lazy var kingdomTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Kingdom",
                                 weight: .regular,
                                 size: 15,
                                 color: .lightGray,
                                 alignment: .left)
    }()
    
    private lazy var kingdomDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                 weight: .bold,
                                 size: 18,
                                 color: .white,
                                 alignment: .left)
    }()
    
    private lazy var classTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Class",
                                        weight: .regular,
                                        size: 15,
                                        color: .lightGray,
                                        alignment: .left)
    }()
    
    private lazy var classDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                        weight: .bold,
                                        size: 18,
                                        color: .white,
                                        alignment: .left)
    }()
    
    private lazy var familyTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Family",
                                        weight: .regular,
                                        size: 15,
                                        color: .lightGray,
                                        alignment: .left)
    }()
    
    private lazy var familyDataLaabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                        weight: .bold,
                                        size: 18,
                                        color: .white,
                                        alignment: .left)
    }()
    
    private lazy var phylumTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Phylum",
                                        weight: .regular,
                                        size: 15,
                                        color: .lightGray,
                                        alignment: .left)
    }()
    
    private lazy var phylumDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                        weight: .bold,
                                        size: 18,
                                        color: .white,
                                        alignment: .left)
    }()
    
    private lazy var orderTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Order",
                                        weight: .regular,
                                        size: 15,
                                        color: .lightGray,
                                        alignment: .left)
    }()
    
    private lazy var orderDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                        weight: .bold,
                                        size: 18,
                                        color: .white,
                                        alignment: .left)
    }()
    
    private lazy var genusTitleLabel: UILabel = {
        return Factory.makeLabel(title: "Genus",
                                        weight: .regular,
                                        size: 15,
                                        color: .lightGray,
                                        alignment: .left)
    }()
    
    private lazy var genusDataLabel: UILabel = {
        return Factory.makeLabel(title: "DATA ENTRY",
                                        weight: .bold,
                                        size: 18,
                                        color: .white,
                                        alignment: .left)
    }()
}

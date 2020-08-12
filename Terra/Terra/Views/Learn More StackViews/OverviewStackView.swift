//
//  OverviewStackView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class OverviewStackView: UIStackView {
    private lazy var overviewSummaryView: OverviewSummaryView = {
           return OverviewSummaryView()
       }()
       
       private lazy var overviewDistributionView: OverviewDistributionView = {
           return OverviewDistributionView()
       }()
}

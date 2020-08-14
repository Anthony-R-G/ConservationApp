//
//  LearnMoreContentWindowStrategy.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

protocol LearnMoreContentWindowStrategy {
    var species: Species { get set }
    func titleLabel() -> String
    func contentView() -> UIView
}

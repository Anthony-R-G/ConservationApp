//
//  NewsHeaderDelegate.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/29/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

protocol NewsHeaderDelegate: AnyObject {
    func shareButtonTapped()
    func refreshButtonTapped()
    func headerLabelTapped()
}

//
//  InfoOptionPanelDelegate.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/20/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import UIKit

protocol InfoOptionPanelDelegate: AnyObject {
    func overviewButtonPressed(_ sender: UIButton)
    func threatsButtonPressed(_ sender: UIButton)
    func habitatButtonPressed(_ sender: UIButton)
    func galleryButtonPressed(_ sender: UIButton)
}

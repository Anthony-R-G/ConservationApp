//
//  ConservationStatus.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/14/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

enum ConservationStatus: String, FirebaseConvertible {
    case critical = "Critical"
    case endangered = "Endangered"
    case vulnerable = "Vulnerable"
}

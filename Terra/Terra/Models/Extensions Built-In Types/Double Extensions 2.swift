//
//  Double Extensions.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/27/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

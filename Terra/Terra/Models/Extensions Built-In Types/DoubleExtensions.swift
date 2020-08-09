//
//  DoubleExtensions.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/6/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    //Mark: Used on MapVC
    var metersToMiles: Double { return self * 0.000621371192 }

}

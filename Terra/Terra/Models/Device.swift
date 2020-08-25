//
//  Device.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class Device {
    //Width of iPhone 11 Pro Max
    static let base: CGFloat = 414
    
    static var ratio: CGFloat {
        return UIScreen.main.bounds.width / base
    }
}

extension CGFloat {
    var deviceAdjusted: CGFloat {
        return self * Device.ratio
    }
}
extension Double {
    var deviceAdjusted: CGFloat {
        return CGFloat(self) * Device.ratio
    }
}
extension Int {
    var deviceAdjusted: CGFloat {
        return CGFloat(self) * Device.ratio
    }
}

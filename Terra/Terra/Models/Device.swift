//
//  Device.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/24/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import AVFoundation

final class Device {
    //Width of iPhone 11 Pro Max
    static let base: CGFloat = 414
    
    static var ratio: CGFloat {
        return UIScreen.main.bounds.width / base
    }
    
    private init() {}
}

extension CGFloat {
    var deviceScaled: CGFloat {
        return self * Device.ratio
    }
}
extension Double {
    var deviceScaled: CGFloat {
        return CGFloat(self) * Device.ratio
    }
}
extension Int {
    var deviceScaled: CGFloat {
        return CGFloat(self) * Device.ratio
    }
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

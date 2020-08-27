//
//  Constants.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/25/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

struct Constants {
    static let reuseIdentifier = "cellId"
    static let spacing: CGFloat = 20.deviceScaled
    static let cornerRadius: CGFloat = 20.deviceScaled
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenWidth = UIScreen.main.bounds.size.width
    static let buttonSize = CGSize(width: 35.deviceScaled, height: 35.deviceScaled)
    static let commonViewSize: CGSize = CGSize(
    width: UIScreen.main.bounds.size.width * 1.2077,
    height: UIScreen.main.bounds.size.height * 0.558)
    
    struct Color {
        static let titleLabelColor = #colorLiteral(red: 0.9257398248, green: 1, blue: 0.7623538375, alpha: 1)
        static let criticalStatusColor = #colorLiteral(red: 1, green: 0.2901960784, blue: 0.3882352941, alpha: 0.9485498716)
        static let endangeredStatusColor = #colorLiteral(red: 0.9961758256, green: 0.3767263889, blue: 0.1716631651, alpha: 1)
        static let vulnerableStatusColor = #colorLiteral(red: 0.6861364245, green: 0.6420921087, blue: 0.08179389685, alpha: 1)
        static let red = #colorLiteral(red: 1, green: 0.2901960784, blue: 0.3882352941, alpha: 0.9485498716)
    }
}

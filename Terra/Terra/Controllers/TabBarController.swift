//
//  TabBarController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/2/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import FloatingTabBarController

class FloatingTabViewController: FloatingTabBarController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setTabItemIcons() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tabBar.visualEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        tabBar.tintColor = .white
        
        let firstVC = SpeciesListViewController()
        let leopardSmallIcon = UIImage(named: "leopardSmall")!
        let leopardLargeIcon = UIImage(named: "leopardLarge")!
        firstVC.floatingTabItem = FloatingTabItem(selectedImage: leopardLargeIcon, normalImage: leopardSmallIcon)
        
        
        let secondVC = NewsViewController()
        let newsSmallIcon = UIImage(named: "newsSmall")!
        let newsLargeIcon = UIImage(named: "newsLarge")!
        secondVC.floatingTabItem = FloatingTabItem(selectedImage: newsLargeIcon, normalImage: newsSmallIcon)
        
        viewControllers = [firstVC, secondVC ]
    }
}

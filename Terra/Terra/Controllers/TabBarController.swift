//
//  TabBarController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/2/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import BATabBarController

class TabBarViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        let tabBarVC = BATabBarController()
        
        super.viewDidLoad()
        let listVC = SpeciesListViewController()
        let newsVC = NewsViewController()
        
        let listVCTabBarItem = BATabBarItem(image: UIImage(named: "listVCUnselected")!, selectedImage: UIImage(named: "listVCSelected")!)
        listVCTabBarItem.tintColor = .white
        
        let newsVCTabBarItem = BATabBarItem(image: UIImage(named: "newsVCUnselected")!, selectedImage: UIImage(named: "newsVCSelected")!)
        newsVCTabBarItem.tintColor = .white
        
        tabBarVC.delegate = self
        tabBarVC.tabBarItemStrokeColor = .white
        tabBarVC.tabBarItemLineWidth = 1
        tabBarVC.viewControllers = [ listVC, newsVC ]
        tabBarVC.tabBarItems = [ listVCTabBarItem, newsVCTabBarItem ]
        
        view.addSubview(tabBarVC.view)
    }
}



extension TabBarViewController: BATabBarControllerDelegate {
    func tabBarController(_ tabBarController: BATabBarController, didSelect: UIViewController) {

    }
}

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
        let newsVC = UINavigationController(rootViewController: NewsViewController())
        newsVC.navigationBar.prefersLargeTitles = true
        newsVC.navigationBar.topItem?.title = "Wildlife News"
        newsVC.navigationBar.barStyle = .black
        newsVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9257398248, green: 1, blue: 0.7623538375, alpha: 1)]
        
        
        
        let listVCTabBarItem = BATabBarItem(image: UIImage(named: "listVCUnselected")!, selectedImage: UIImage(named: "listVCSelected")!)
        listVCTabBarItem.tintColor = #colorLiteral(red: 0.9257398248, green: 1, blue: 0.7623538375, alpha: 1)
        
        let newsVCTabBarItem = BATabBarItem(image: UIImage(named: "newsVCUnselected")!, selectedImage: UIImage(named: "newsVCSelected")!)
        newsVCTabBarItem.tintColor = #colorLiteral(red: 0.9257398248, green: 1, blue: 0.7623538375, alpha: 1)
        
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

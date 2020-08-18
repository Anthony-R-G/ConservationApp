//
//  TabBarController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/2/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import BATabBarController

final class TabBarViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarVC = BATabBarController()
        
        let listVC = SpeciesListViewController()
        
        let newsVC = UINavigationController(rootViewController: NewsViewController())
        newsVC.navigationBar.prefersLargeTitles = true
        newsVC.navigationBar.topItem?.title = "Wildlife News"
        newsVC.navigationBar.barStyle = .black
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: Constants.titleLabelColor]
        newsVC.navigationBar.largeTitleTextAttributes = textAttributes
        newsVC.navigationBar.titleTextAttributes = textAttributes
        
        
        let listVCTabBarItem = BATabBarItem(image: UIImage(named: "listVCUnselected")!, selectedImage: UIImage(named: "listVCSelected")!)
        listVCTabBarItem.tintColor = Constants.buttonColor
        
        let newsVCTabBarItem = BATabBarItem(image: UIImage(named: "newsVCUnselected")!, selectedImage: UIImage(named: "newsVCSelected")!)
        newsVCTabBarItem.tintColor = Constants.buttonColor
        
        tabBarVC.delegate = self
        tabBarVC.tabBarItemStrokeColor = .white
        tabBarVC.tabBarItemLineWidth = Constants.borderWidth
        tabBarVC.viewControllers = [ listVC, newsVC ]
        tabBarVC.tabBarItems = [ listVCTabBarItem, newsVCTabBarItem ]
        tabBarVC.tabBarBackgroundColor = .black
        
        view.addSubview(tabBarVC.view)
    }
}



extension TabBarViewController: BATabBarControllerDelegate {
    func tabBarController(_ tabBarController: BATabBarController, didSelect: UIViewController) {
        
    }
}

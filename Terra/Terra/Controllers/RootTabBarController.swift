//
//  TestBarController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import MaterialComponents.MaterialBottomNavigation

final class RootTabBarController: UITabBarController {
    
    //MARK: -- UI Elements
    
    private lazy var bottomNavigationBar: MDCBottomNavigationBar = {
        let navBar = MDCBottomNavigationBar()
        navBar.delegate = self
        navBar.backgroundColor = .black
        navBar.selectedItemTintColor = #colorLiteral(red: 0.9257398248, green: 1, blue: 0.7623538375, alpha: 1)
        navBar.unselectedItemTintColor = .darkGray
        return navBar
    }()
    
    //MARK: -- Methods
    
    private func layoutBottomNavigationBar() {
        let size = bottomNavigationBar.sizeThatFits(view.bounds.size)
        var bottomNavBarFrame = CGRect(x: 0,
                                       y: view.bounds.height - size.height,
                                       width: size.width,
                                       height: size.height)
        
        bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
        bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
        
        bottomNavigationBar.frame = bottomNavBarFrame
    }
    
    private func configureTabBarItems() {
        let listVCTabBarItem = UITabBarItem(title: nil,
                                            image: #imageLiteral(resourceName: "ListVCTabBarItemGlyph"),
                                            tag: 0)
        
        let newsVCTabBarItem = UITabBarItem(title: nil,
                                            image: #imageLiteral(resourceName: "MapVCGlyph"),
                                            tag: 1)
        
        bottomNavigationBar.items = [ listVCTabBarItem, newsVCTabBarItem ]
        bottomNavigationBar.selectedItem = listVCTabBarItem
    }
    
    private func configureViewControllers() {
        let listVC = SpeciesListViewController()
        
        let newsVC = UINavigationController(rootViewController: NewsViewController())
        
        newsVC.navigationBar.prefersLargeTitles = true
        newsVC.navigationBar.topItem?.title = "Wildlife News"
        newsVC.navigationBar.barStyle = .black
        
        let largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Constants.Color.titleLabelColor,
            NSAttributedString.Key.font: UIFont(name: "Roboto-Black", size: 40.deviceAdjusted)]
        
        let regularTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Constants.Color.titleLabelColor,
        NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 20.deviceAdjusted)]
        
        newsVC.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes as [NSAttributedString.Key : Any]
        newsVC.navigationBar.titleTextAttributes = regularTitleTextAttributes as [NSAttributedString.Key : Any]
        viewControllers = [listVC, newsVC]
    }
    
    //MARK: -- Life Cycle Methods
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutBottomNavigationBar()
    }
    
    override func viewDidLoad() {
        view.addSubview(bottomNavigationBar)
        configureTabBarItems()
        configureViewControllers()
    }
}

//MARK: -- MDC Bottom Nav Bar Delegate

extension RootTabBarController: MDCBottomNavigationBarDelegate {
    
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        guard
            let fromView = selectedViewController?.view,
            let toView = customizableViewControllers?[item.tag].view
            else { return }
        
        if fromView != toView { UIView.transition (
            from: fromView,
            to: toView,
            duration: 0.3,
            options: [.transitionCrossDissolve],
            completion: nil)
        }
        
        selectedIndex = item.tag
    }
}

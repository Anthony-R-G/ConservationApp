//
//  NewsViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/2/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching News Data ...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return refreshControl
    }()
    
    
    @objc func handleRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.refreshControl.endRefreshing()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}

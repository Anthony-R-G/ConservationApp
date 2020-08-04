//
//  NewsViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/2/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching News Data ...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        return refreshControl
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(NewsArticleTableViewCell.self, forCellReuseIdentifier: "newsCell")
        tv.backgroundColor = .white
        tv.refreshControl = refreshControl
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    //MARK: -- Properties
    
    var newsArticles: [Article] = []  {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    //MARK: -- Methods
    
    @objc func handleRefresh() {
        fetchNewsData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func fetchNewsData() {
        NewsAPIClient.shared.fetchNewsData { (result) in
            switch result {
            case .success(let newsData):
                self.newsArticles = newsData
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showModally(_ viewController: UIViewController) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let rootViewController = window?.rootViewController
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    private func presentWebBrowser(link: URL){
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        let safariVC = SFSafariViewController(url: link, configuration: config)
        showModally(safariVC)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
        fetchNewsData()
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsArticleTableViewCell
        let specificArticle = newsArticles[indexPath.row]
        newsCell.configureCellUI(from: specificArticle)
        return newsCell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleURL = newsArticles[indexPath.row].url
        if articleURL.isValidURL {
            presentWebBrowser(link: URL(string: articleURL)!)
        }
    }
}


//MARK: -- Add Subviews & Constraints

fileprivate extension NewsViewController {
    
    func addSubviews() {
        let UIElements = [tableView]
        UIElements.forEach { view.addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setTableViewConstraints()
    }
    
    func setTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }
}

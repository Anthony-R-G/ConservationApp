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
        refreshControl.tintColor = .lightGray
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching News Data ...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return refreshControl
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(NewsArticleTableViewCell.self, forCellReuseIdentifier: "newsCell")
        tv.backgroundColor = .clear
        tv.refreshControl = refreshControl
        tv.separatorColor = .white
        tv.dataSource = self
        tv.delegate = self
        tv.prefetchDataSource = self
        tv.indicatorStyle = .white
        return tv
    }()
    
    //MARK: -- Properties
    
    var newsArticles: [Article] = []  {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var currentPage: Int = 1
    
    private var isFetchingNews = false
    
    
    //MARK: -- Methods
    
    @objc func handleRefresh() {
        fetchNewsData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func fetchNewsData() {
        isFetchingNews = true
        NewsAPIClient.shared.fetchNewsData(page: currentPage) { (result) in
            switch result {
            case .success(let newsData):
                self.newsArticles.append(contentsOf: newsData.articles)
                self.currentPage += 1
                print("Page: \(self.currentPage)")
                print(newsData.totalResults)
                self.isFetchingNews = false
                
                
            case .failure(let error):
                print(error)
                self.isFetchingNews = false
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
        view.backgroundColor = .black
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

extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row > newsArticles.count - 3 && !isFetchingNews {
                fetchNewsData()
                break
            }
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
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }
}

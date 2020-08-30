//
//  NewsViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/2/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices

final class NewsCollectionViewController: UICollectionViewController {
    
    //MARK: -- Properties
    
    private var viewModel: NewsViewModel!
    
    private var headerView: NewsCollectionViewHeader!
    
    fileprivate let headerID = "headerID"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: -- Methods
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(NewsCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.register(NewsArticleTableViewCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        collectionView.scrollsToTop = true
        collectionView.prefetchDataSource = self
    }
    
    private func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel = NewsViewModel(delegate: self)
        viewModel.fetchNews()
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    //MARK: -- Collection View Data Source Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalNewsArticlesCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as! NewsArticleTableViewCell
        newsCell.delegate = self
        newsCell.shareButton.tag = indexPath.row
        let specificArticle = viewModel.specificArticle(at: indexPath.row)
        newsCell.configureCell(from: specificArticle)
        return newsCell
    }
    
    
    //MARK: -- Collection View Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as? NewsCollectionViewHeader)!
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: Constants.screenWidth, height: 320.deviceScaled)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didHighlightItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        Utilities.sendHapticFeedback(action: .itemSelected)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArticle = viewModel.specificArticle(at: indexPath.row)
        Utilities.presentWebBrowser(on: self, link: URL(string: selectedArticle.url)!)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 0 {
            headerView.animator.fractionComplete = 0
            return
        }
        
        headerView.animator.fractionComplete = abs(contentOffsetY) / 100
    }
}

extension NewsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.screenWidth, height: 180.deviceScaled)
    }
}

extension NewsCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row > viewModel.totalNewsArticlesCount - 3 && !viewModel.newsFetchIsUnderway {
                viewModel.fetchNews()
                break
            }
        }
    }
}

extension NewsCollectionViewController: NewsViewModelDelegate {
    func fetchCompleted() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.headerView.configureHeader(from: self.viewModel.specificArticle(at: 0))
        }
    }
}

extension NewsCollectionViewController: ShareButtonDelegate {
    func shareButtonTapped(sender: UIButton) {
        let cellIndex = sender.tag
        let selectedArticle = viewModel.specificArticle(at: cellIndex)
        let items = [URL(string: selectedArticle.url)!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}

//
//  NewsViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/2/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices
import Combine

fileprivate typealias NewsDataSource = UICollectionViewDiffableDataSource<NewsViewController.Section, NewsArticle>

fileprivate typealias NewsSnapshot = NSDiffableDataSourceSnapshot<NewsViewController.Section, NewsArticle>


final class NewsViewController: UIViewController {
    
    //MARK: -- UI Element Initialization
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(
            origin: .zero,
            size: CGSize(
                width: Constants.screenWidth,
                height: Constants.screenHeight))
            , collectionViewLayout: StretchyCollectionViewHeaderLayout())
        
        if let layout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(
                top: Constants.spacing,
                left: Constants.spacing,
                bottom: Constants.spacing,
                right: Constants.spacing)
        }
        
        cv.contentInsetAdjustmentBehavior = .never
        cv.register(NewsCollectionViewHeader.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: NewsCollectionViewHeader.reuseIdentifier)
        cv.register(NewsArticleCollectionViewCell.self,
                    forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        
        cv.scrollsToTop = true
        
        cv.prefetchDataSource = self
        
        cv.delegate = self
        return cv
    }()
    
    //MARK: -- Properties
    
    private lazy var viewModel: NewsViewModel = {
        return NewsViewModel()
    }()
    
    private lazy var dataSource: NewsDataSource = makeDataSource()
    
    private var headerView: NewsCollectionViewHeader?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: -- Methods
    
    private func makeDataSource() -> NewsDataSource {
        let dataSource = NewsDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, newsArticle) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: Constants.cellReuseIdentifier,
                    for: indexPath) as? NewsArticleCollectionViewCell
                    else { return UICollectionViewCell() }
                cell.configureCell(from: newsArticle)
                cell.shareButton.tag = indexPath.row
                cell.delegate = self
                return cell
        })
        
        dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            
            self.headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: NewsCollectionViewHeader.reuseIdentifier,
                for: indexPath) as? NewsCollectionViewHeader
            
            guard let headerView = self.headerView else { return UICollectionReusableView() }
            headerView.delegate = self
            return headerView
        }
        
        return dataSource
    }
    
    private func makeSnapshot(from newsData: [NewsArticle]) {
        var snapshot = NewsSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(newsData)
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    
    
    private func bindViewModel() {
        Publishers.CombineLatest(viewModel.$firstNewsArticle, viewModel.$filteredNewsArticles)
            .receive(on: RunLoop.main)
            .sink{ [unowned self] (newsArticleResponse) in
                self.makeSnapshot(from: newsArticleResponse.1)
                if let firstArticle = newsArticleResponse.0 {
                    self.headerView?.configureHeader(from: firstArticle)
                    self.headerView?.stopButtonLoading()
                }
        }
        .store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchNews(fetchType: .replace)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        addSubviews()
        setConstraints()
    }
}

//MARK: -- Collection View Prefetching
extension NewsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row > viewModel.filteredNewsArticles.count - 3 && !viewModel.isFetchInProgress {
                viewModel.fetchNews(fetchType: .append)
            }
        }
    }
}


//MARK: -- Collection View Delegate Methods

extension NewsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: Constants.screenWidth, height: 290.deviceScaled)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        Utilities.sendHapticFeedback(action: .itemSelected)
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        UIView.animate(withDuration: 0.3) {
            cell.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        UIView.animate(withDuration: 0.3) {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let selectedArticle = dataSource.itemIdentifier(for: indexPath),
            let url = URL(string: selectedArticle.url)
            else { return }
        Utilities.presentWebBrowser(on: self, link: url, delegate: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 2 * Constants.spacing, height: 160.deviceScaled)
    }
}

extension NewsViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("boom")
    }
}

//MARK: -- Custom Delegates

extension NewsViewController: NewsCellDelegate {
    func shareButtonTapped(sender: UIButton) {
        let cellIndex = sender.tag
        guard
            let selectedArticle = viewModel.specificArticle(at: cellIndex),
            let selectedArticleUrl = URL(string: selectedArticle.url)
            else { return }
        Utilities.presentActivityController(on: self, items: [selectedArticleUrl])
    }
}

extension NewsViewController: NewsHeaderDelegate {
    func shareButtonTapped() {
        guard
            let firstArticle = viewModel.firstNewsArticle,
            let firstArticleUrl = URL(string: firstArticle.url)
            else { return }
        Utilities.presentActivityController(on: self, items: [firstArticleUrl])
    }
    
    func refreshButtonTapped() {
        viewModel.fetchNews(fetchType: .replace)
    }
    
    func headerLabelTapped() {
        guard
            let firstArticle = viewModel.firstNewsArticle,
            let firstArticleUrl = URL(string: firstArticle.url)
            else { return }
        Utilities.presentWebBrowser(on: self, link: firstArticleUrl, delegate: self)
    }
}


//MARK: -- Add Subviews & Constraints

fileprivate extension NewsViewController {
    func addSubviews() {
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension NewsViewController {
    fileprivate enum Section {
        case main
    }
}

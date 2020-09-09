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
      private var sections = Section.main
    
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
        let viewModel = NewsViewModel(delegate: self)
        return viewModel
    }()
    
    private lazy var dataSource: NewsDataSource = makeDataSource()
    
    private var headerView: NewsCollectionViewHeader?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private var previousStatusBarHidden = false
    
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
                
                return cell
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
          
            self.headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: NewsCollectionViewHeader.reuseIdentifier,
                for: indexPath) as? NewsCollectionViewHeader
            
            guard let headerView = self.headerView else { return UICollectionReusableView() }
    
            return headerView
            
        }
        return dataSource
    }
    
    private func makeSnapshot(from newsData: [NewsArticle]) {
        var snapshot = NewsSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(newsData.dropFirst()))
    
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    
    private func bindViewModel() {
        viewModel.$filteredNewsArticles
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] (newsArticleData) in
                    guard let self = self else { return }
                    self.makeSnapshot(from: newsArticleData)
                    self.headerView?.configureHeader(from: self.viewModel.firstArticle!)
            })
            .store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchNews(fetchType: .replace)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        bindViewModel()
        addSubviews()
        setConstraints()
    }
}

//MARK: -- Collection View Data Source Methods

/*
extension NewsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredNewsArticles.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as! NewsArticleCollectionViewCell
        newsCell.delegate = self
        newsCell.shareButton.tag = indexPath.row
        let specificArticle = viewModel.specificArticle(at: indexPath.row + 1)
        newsCell.configureCell(from: specificArticle)
        return newsCell
    }
}

 */
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
    /*
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        headerView = (
            collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: headerID,
                for: indexPath) as? NewsCollectionViewHeader)
        guard let headerView = headerView else { return UICollectionReusableView() }
        headerView.delegate = self
        return headerView
    }
 */
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: Constants.screenWidth, height: 290.deviceScaled)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        Utilities.sendHapticFeedback(action: .itemSelected)
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedArticle = viewModel.specificArticle(at: indexPath.row + 1)
        guard let url = URL(string: selectedArticle.url) else { return }
        Utilities.presentWebBrowser(on: self, link: url, delegate: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let contentOffsetY = scrollView.contentOffset.y
    //
    //        if contentOffsetY > 0 {
    //            headerView.animator.fractionComplete = 0
    //            return
    //        }
    //
    //        headerView.animator.fractionComplete = abs(contentOffsetY) / 100
    //    }
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
extension NewsViewController: NewsViewModelDelegate {
    func fetchCompleted() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            //            self.collectionView.reloadData()
            //            self.headerView?.configureHeader(from: self.viewModel.specificArticle(at: 0))
            //            self.headerView?.stopButtonLoading()
        }
    }
}

extension NewsViewController: NewsCellDelegate {
    func shareButtonTapped(sender: UIButton) {
        let cellIndex = sender.tag
        let selectedArticle = viewModel.specificArticle(at: cellIndex)
        Utilities.presentActivityController(on: self, items: [URL(string: selectedArticle.url)!])
    }
}

extension NewsViewController: NewsHeaderDelegate {
    func shareButtonTapped() {
        let selectedArticle = viewModel.specificArticle(at: 0)
        Utilities.presentActivityController(on: self, items: [URL(string: selectedArticle.url)!])
    }
    
    func refreshButtonTapped() {
        viewModel.fetchNews(fetchType: .replace)
    }
    
    func headerLabelTapped() {
        Utilities.presentWebBrowser(on: self, link: URL(string: viewModel.specificArticle(at:0).url)!, delegate: self)
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

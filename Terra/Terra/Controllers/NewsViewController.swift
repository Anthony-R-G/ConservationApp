//
//  NewsViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/2/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit
import SafariServices

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
                    withReuseIdentifier: headerID)
        cv.register(NewsArticleCollectionViewCell.self,
                    forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        cv.scrollsToTop = true
        cv.dataSource = self
        cv.prefetchDataSource = self
        cv.delegate = self
        return cv
    }()
    
    //MARK: -- Properties
    
    fileprivate let headerID = "headerID"
    
    private var viewModel: NewsViewModel!
    
    private var headerView: NewsCollectionViewHeader!
    
    private var previousStatusBarHidden = false
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
           return .slide
       }
       
//    override var prefersStatusBarHidden: Bool {
//        return shouldHideStatusBar
//       }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: -- Methods
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel = NewsViewModel(delegate: self)
        viewModel.fetchNews(fetchType: .replace)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubviews()
        setConstraints()
    }
}

//MARK: -- Collection View Data Source Methods

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
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        headerView = (
            collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: headerID,
            for: indexPath) as? NewsCollectionViewHeader)!
        
        headerView.delegate = self
        return headerView
    }
    
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
        Utilities.presentWebBrowser(on: self, link: URL(string: selectedArticle.url)!, delegate: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        updateStatusBarVisibility()
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 0 {
            headerView.animator.fractionComplete = 0
            return
        }
        
        headerView.animator.fractionComplete = abs(contentOffsetY) / 100
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
extension NewsViewController: NewsViewModelDelegate {
    func fetchCompleted() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.headerView.configureHeader(from: self.viewModel.specificArticle(at: 0))
            self.headerView.stopButtonLoading()
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

/*
extension NewsViewController {
    
    private var shouldHideStatusBar: Bool {
        let frame = collectionView.convert(collectionView.bounds, to: nil)

        return frame.minY < view.safeAreaInsets.top
    }
    
    private func updateStatusBarVisibility() {
        if previousStatusBarHidden != shouldHideStatusBar {
            
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self = self else { return }
                self.setNeedsStatusBarAppearanceUpdate()
            })
            
            previousStatusBarHidden = shouldHideStatusBar
        }
    }
}
*/

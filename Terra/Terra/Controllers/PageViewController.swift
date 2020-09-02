//
//  PageViewController.swift
//  Terra
//
//  Created by Anthony Gonzalez on 9/1/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class PageViewController: UIPageViewController {
    
    //MARK: -- Properties
    private let onboardingPages: [UIViewController]  = [
        OnboardingViewController(strategy: OnboardingPageOne()),
        OnboardingViewController(strategy: OnboardingPageTwo())
    ]
    
    //MARK: -- Methods
    
    private func setViewControllers() {
        setViewControllers(
            [onboardingPages[0]],
            direction: .forward,
            animated: true,
            completion: nil)
        dataSource = self
    }
    
    private func customizePageControl() {
        let pageControl = UIPageControl.appearance()
        pageControl.backgroundColor = .black
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = Constants.Color.titleLabelColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        customizePageControl()
    }
    
    init() {
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Page ViewController Data Source
extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = onboardingPages.firstIndex(of: viewController) else { return nil }
        guard index - 1 >= 0 else { return nil }
        return onboardingPages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = onboardingPages.firstIndex(of: viewController) else { return nil }
        guard index + 1 < onboardingPages.count else { return nil }
        return onboardingPages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return onboardingPages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}



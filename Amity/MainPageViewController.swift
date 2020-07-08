//
//  MainViewController.swift
//  Amity
//
//  Created by Abhishek Jadhav on 23/06/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    fileprivate var items: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        decoratePageControl()
        
        populateItems()
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    fileprivate func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [MainPageViewController.self])
        pc.currentPageIndicatorTintColor = .orange
        pc.pageIndicatorTintColor = .gray
    }
    
    fileprivate func populateItems() {
        
        let pageModels = [
            PageModel(index: 0, pageInfo: " Exceteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt", pageDescription: "", pageImage:#imageLiteral(resourceName: "screen1"),pageDescriptionImage: #imageLiteral(resourceName: "amitylogo (3)")),
            PageModel(index: 1, pageInfo: "LEARN", pageDescription: "Learn new emerging technologies like AI/ML", pageImage:#imageLiteral(resourceName: "screen2"),pageDescriptionImage:#imageLiteral(resourceName: "amitylogo (3)")),
            PageModel(index: 2, pageInfo: "CONNECT", pageDescription: "Be a part of a like minded community across the globe", pageImage: #imageLiteral(resourceName: "screen3"),pageDescriptionImage:#imageLiteral(resourceName: "amitylogo (3)")),
            PageModel(index: 3, pageInfo: "GROW", pageDescription: "Grow in your career based on new skills", pageImage: #imageLiteral(resourceName: "screen4"),pageDescriptionImage:#imageLiteral(resourceName: "amitylogo (3)"))
        ]
        
        for pageModel in pageModels {
            let pageController = createPageController(with: pageModel.pageInfo, and: pageModel.pageImage, descriptionLabel: pageModel.pageDescription, descriptionImage: pageModel.pageDescriptionImage,index: pageModel.index)
            items.append(pageController)
        }
    }
    
    fileprivate func createPageController(with pageName: String, and pageImage: UIImage,descriptionLabel: String,descriptionImage: UIImage,index:Int) -> UIViewController{
        let pageVC = UIViewController()
        let pView: PageView = PageView(titleText: pageName, image: pageImage,description: descriptionLabel,descriptionImage:descriptionImage,index:index)
        pageVC.view = pView
        return pageVC
    }
    
}

extension MainPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return items.last
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
   
}

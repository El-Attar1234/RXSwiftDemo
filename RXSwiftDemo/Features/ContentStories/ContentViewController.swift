//
//  ContentViewController.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 05/01/2023.
//

import UIKit

class ContentViewController: UIViewController {
    private var pageController: UIPageViewController?
   // private var currentIndex: Int = 0
    var vcs = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageController()
        // Do any additional setup after loading the view.
    }
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
       // pageController.v
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .yellow
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .red
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .green
        vcs.append(vc1)
        vcs.append(vc2)
        vcs.append(vc3)
        pageController!.setViewControllers([vcs[0]] , direction: .reverse, animated: false)
       self.pageController?.view.backgroundColor = .clear
//        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        self.pageController?.view.frame = view.bounds
        addChild(pageController!)
        self.view.addSubview(self.pageController!.view)
        view.sendSubviewToBack(pageController!.view)
        self.pageController?.didMove(toParent: self)
    }
    
    
}

extension ContentViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        print("Pager Before\(viewController)")
        guard let currentIndex = vcs.firstIndex(of: viewController) else {return nil }
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else {return nil }
        return vcs[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("Pager After")
//        let vc = UIViewController()
//        vc.view.backgroundColor = .green
//        return vc
        
        guard let currentIndex = vcs.firstIndex(of: viewController) else {return nil }
        let nextIndex = currentIndex + 1
        guard nextIndex < vcs.count else {return nil }
        return vcs[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        print("Pager presentationCount")
        setupPageControl()
        return 3
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        print("Pager presentationIndex")
        
        return 0
    }
    
    private func setupPageControl() {
           let appearance = UIPageControl.appearance()
           appearance.pageIndicatorTintColor = UIColor.darkGray
           appearance.currentPageIndicatorTintColor = UIColor.red
           appearance.backgroundColor = UIColor.black
       }

    
}

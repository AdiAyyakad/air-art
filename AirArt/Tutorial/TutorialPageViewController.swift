//
//  TutorialPageViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 11/30/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    private(set) lazy var orderedViewControllers: [TutorialViewController] = {
        return [
            self.newTutorialViewController(page: "First"),
            self.newTutorialViewController(page: "Second"),
            self.newTutorialViewController(page: "Third")
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }

    private func newTutorialViewController(page name: String) -> TutorialViewController {

        guard let storyboard = self.storyboard else {
            print("Failed to get storyboard")
            return TutorialViewController()
        }

        guard let tvc = storyboard.instantiateViewController(withIdentifier: name) as? TutorialViewController else {
            print("Failed to get TVC")
            return TutorialViewController()
        }

        tvc.pageViewController = self
        return tvc

    }

}

// MARK: Page Actions

extension TutorialPageViewController {

    func next(from page: Int) {
        setViewControllers([orderedViewControllers[page+1]],
                                direction: .forward,
                                animated: true,
                                completion: nil)
    }

    func prev(from page: Int) {
        setViewControllers([orderedViewControllers[page-1]],
                                direction: .reverse,
                                animated: true,
                                completion: nil)
    }

    func done(from page: Int) {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: UIPageViewControllerDataSource

extension TutorialPageViewController: UIPageViewControllerDataSource {

    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let vc = viewController as? TutorialViewController,
            let viewControllerIndex = orderedViewControllers.index(of: vc),
            viewControllerIndex - 1 >= 0,
            viewControllerIndex - 1 < orderedViewControllers.count else {
            return nil
        }

        return orderedViewControllers[viewControllerIndex - 1]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let vc = viewController as? TutorialViewController,
            let viewControllerIndex = orderedViewControllers.index(of: vc),
            viewControllerIndex + 1 >= 0,
            viewControllerIndex + 1 < orderedViewControllers.count else {
            return nil
        }

        return orderedViewControllers[viewControllerIndex + 1]

    }

}

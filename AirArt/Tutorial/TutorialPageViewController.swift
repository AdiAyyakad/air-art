//
//  TutorialPageViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 11/30/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    var currentIndex: Int = 0
    private(set) lazy var orderedViewControllers: [TutorialViewController] = {
        return [
            self.newTutorialViewController(page: "First"),
            self.newTutorialViewController(page: "Second"),
            self.newTutorialViewController(page: "Third")
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

}

// MARK: - Setup

extension TutorialPageViewController {

    func setup() {

        dataSource = self

        setViewControllers([orderedViewControllers[currentIndex]],
                           direction: .forward,
                           animated: true,
                           completion: nil)

    }

}

// MARK: - Helpers

private extension TutorialPageViewController {

    func newTutorialViewController(page name: String) -> TutorialViewController {

        guard let storyboard = self.storyboard,
            let tvc = storyboard.instantiateViewController(withIdentifier: name) as? TutorialViewController else {
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

    func done() {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: UIPageViewControllerDataSource

extension TutorialPageViewController: UIPageViewControllerDataSource {

    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard currentIndex > 0 else {
            return nil
        }

        currentIndex -= 1
        return orderedViewControllers[currentIndex]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard currentIndex < orderedViewControllers.count - 1 else {
            return nil
        }

        currentIndex += 1
        return orderedViewControllers[currentIndex]

    }

}

//
//  CalibrationPageViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 11/30/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class CalibrationPageViewController: UIPageViewController {

    var currentIndex: Int = 0
    private(set) lazy var orderedViewControllers: [CalibrationViewController] = {
        return [
            self.newCalibrationViewController(page: "First"),
            self.newCalibrationViewController(page: "Second")
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

}

// MARK: - Setup

extension CalibrationPageViewController {

    func setup() {
        dataSource = self

        setViewControllers([orderedViewControllers[currentIndex]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }

}

// MARK: - Helpers

private extension CalibrationPageViewController {

    func newCalibrationViewController(page name: String) -> CalibrationViewController {

        guard let storyboard = self.storyboard,
            let cvc = storyboard.instantiateViewController(withIdentifier: name) as? CalibrationViewController else {
            return CalibrationViewController()
        }

        cvc.pageViewController = self
        return cvc

    }

}

// MARK: - Actions

extension CalibrationPageViewController {

    func next() {
        setViewControllers([orderedViewControllers[1]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }

    func prev() {
        setViewControllers([orderedViewControllers[0]],
                           direction: .reverse,
                           animated: true,
                           completion: nil)
    }

    func done() {
        dismiss(animated: true, completion: nil)
    }

}


// MARK: - UIPageViewDataSource

extension CalibrationPageViewController: UIPageViewControllerDataSource {

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

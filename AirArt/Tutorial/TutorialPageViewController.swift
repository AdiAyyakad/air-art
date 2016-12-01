//
//  TutorialPageViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 11/30/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    var isTutorial: Bool! {
        didSet {
            guard let bool = isTutorial else {
                return
            }

            orderedViewControllers = bool ? tutorialViewControllers : calibrationViewControllers
            go(to: 0, direction: .forward)
        }
    }
    var currentIndex: Int = 0
    var orderedViewControllers: [UIViewController] = []
    private(set) lazy var tutorialViewControllers: [UIViewController] = {
        return [
            self.newTutorialViewController(page: "First Tutorial"),
            self.newTutorialViewController(page: "Second Tutorial"),
            self.newTutorialViewController(page: "Third Tutorial"),
            self.newCalibrationViewController(page: "First Calibration"),
            self.newCalibrationViewController(page: "Second Calibration")
        ]
    }()

    private(set) lazy var calibrationViewControllers: [UIViewController] = {
        return [
            self.newCalibrationViewController(page: "First Calibration"),
            self.newCalibrationViewController(page: "Second Calibration")
        ]
    }()

}

// MARK: - Helpers

private extension TutorialPageViewController {

    func newTutorialViewController(page name: String) -> UIViewController {

        guard let storyboard = self.storyboard else {
            return UIViewController()
        }

        return storyboard.instantiateViewController(withIdentifier: name)

    }

    func newCalibrationViewController(page name: String) -> UIViewController {

        guard let storyboard = self.storyboard else {
                return UIViewController()
        }

        return storyboard.instantiateViewController(withIdentifier: name)

    }

}

// MARK: Page Actions

extension TutorialPageViewController {

    func done() {
        dismiss(animated: true, completion: nil)
    }

    func go(to page: Int, direction dir: UIPageViewControllerNavigationDirection) {
        setViewControllers([orderedViewControllers[page]],
                           direction: dir,
                           animated: true,
                           completion: nil)
    }

}

//
//  TutorialPageViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 11/30/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

enum PageViewControllerID: String {
    case Tutorial = "Tutorial"
    case Calibration = "Calibration"
}

class TutorialPageViewController: UIPageViewController {

    var currentIndex: Int = 0
    var orderedViewControllers: [UIViewController]!
    private(set) lazy var tutorialViewControllers: [TutorialViewController] = {
        return [
            self.newTutorialViewController(page: "First"),
            self.newTutorialViewController(page: "Second"),
            self.newTutorialViewController(page: "Third")
        ]
    }()

    private(set) lazy var calibrationViewControllers: [CalibrationViewController] = {
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

extension TutorialPageViewController {

    func setup() {

        currentIndex = 0
        // dataSource = self

        if let id = restorationIdentifier {
            switch id {
            case PageViewControllerID.Tutorial.rawValue:
                orderedViewControllers = tutorialViewControllers
            case PageViewControllerID.Calibration.rawValue:
                orderedViewControllers = calibrationViewControllers
            default:
                orderedViewControllers = nil
            }
        }

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

    func newCalibrationViewController(page name: String) -> CalibrationViewController {

        guard let storyboard = self.storyboard,
            let cvc = storyboard.instantiateViewController(withIdentifier: name) as? CalibrationViewController else {
                return CalibrationViewController()
        }

        cvc.pageViewController = self
        return cvc

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

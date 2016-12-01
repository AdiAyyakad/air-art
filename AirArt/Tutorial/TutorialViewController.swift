//
//  TutorialViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 11/30/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    var isTutorial: Bool!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    weak var pageViewController: TutorialPageViewController! {
        didSet {
            self.pageViewController.isTutorial = self.isTutorial
            self.pageControl.numberOfPages = self.pageViewController.orderedViewControllers.count
        }
    }

    @IBAction func didPressPrev(_ sender: Any) {
        pageControl.currentPage -= 1

        pageViewController.go(to: pageControl.currentPage, direction: .reverse)
        reevaluateLayout()
    }


    @IBAction func didPressNext(_ sender: Any) {
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            pageViewController.done()
        } else {
            pageControl.currentPage += 1

            pageViewController.go(to: pageControl.currentPage, direction: .forward)
            reevaluateLayout()
        }
    }

}

// MARK: - Helpers

private extension TutorialViewController {

    func reevaluateLayout() {
        prevButton.isHidden = pageControl.currentPage == 0
        nextButton.setTitle(pageControl.currentPage == pageControl.numberOfPages - 1 ? "Done" : "Next", for: .normal)
    }

}

// MARK: - Embed Segue

extension TutorialViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.Embed.rawValue {
            guard let pvc = segue.destination as? TutorialPageViewController else {
                return
            }

            pageViewController = pvc
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

}

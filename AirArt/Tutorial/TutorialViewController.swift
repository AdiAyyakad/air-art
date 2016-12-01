//
//  TutorialViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 11/30/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!

    var isTutorial: Bool!
    weak var pageViewController: TutorialPageViewController!

    @IBAction func didPressPrev(_ sender: Any) {
        pageControl.currentPage -= 1

        pageViewController.go(to: pageControl.currentPage)
        reevaluateLayout()
    }


    @IBAction func didPressNext(_ sender: Any) {
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            pageViewController.done()
        } else {
            pageControl.currentPage += 1

            pageViewController.go(to: pageControl.currentPage)
            reevaluateLayout()
        }
    }

}

// MARK: - Helpers

extension TutorialViewController {

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
            pageViewController.isTutorial = isTutorial
            pageViewController.tutorialViewController = self
            pageControl.numberOfPages = self.pageViewController.orderedImages.count
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

}

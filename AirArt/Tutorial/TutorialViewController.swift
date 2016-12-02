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
    @IBOutlet weak var scrollView: UIScrollView!

    var isTutorial: Bool!
    var orderedImages: [UIImage] = []

    private(set) lazy var tutorialImages: [UIImage] = {
        guard let one = UIImage(named: "Walkthrough1.png"),
            let two = UIImage(named: "Walkthrough2.png"),
            let three = UIImage(named: "Walkthrough3.png") else {
                return []
        }

        return [one, two, three]
    }()

    private(set) lazy var calibrationImages: [UIImage] = {
        guard let one = UIImage(named: "Calibration1.png"),
            let two = UIImage(named: "Calibration2.png") else {
                return []
        }

        return [one, two]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupBackground()
    }

}

// MARK: - Setup

extension TutorialViewController {

    func setup() {
        if let bool = isTutorial {
            orderedImages = bool ? tutorialImages : calibrationImages
            pageControl.numberOfPages = orderedImages.count
        }

        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }

    func setupBackground() {
        scrollView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: CGFloat(orderedImages.count)*view.frame.width,
                                  height: view.frame.height)

        for i in 0..<orderedImages.count {
            let imageView = UIView(frame: CGRect(x: CGFloat(i)*view.frame.width,
                                                 y: 0,
                                                 width: view.frame.width,
                                                 height: view.frame.height))
            imageView.addSubview(UIImageView(image: orderedImages[i]))
            scrollView.addSubview(imageView)

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

// MARK: - Actions

extension TutorialViewController {

    @IBAction func didPressPrev(_ sender: Any) {
        pageControl.currentPage -= 1

        go(to: pageControl.currentPage)
        reevaluateLayout()
    }


    @IBAction func didPressNext(_ sender: Any) {
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            done()
        } else {
            pageControl.currentPage += 1

            go(to: pageControl.currentPage)
            reevaluateLayout()
        }
    }

    private func done() {
        dismiss(animated: true, completion: nil)
    }

    private func go(to page: Int) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(page)*view.frame.width, y: 0), animated: true)
    }

}

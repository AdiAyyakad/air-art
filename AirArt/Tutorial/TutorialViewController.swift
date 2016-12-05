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
        setupScrollView()
    }

}

// MARK: - Setup

extension TutorialViewController {

    func setup() {
        if let bool = isTutorial {
            orderedImages = bool ? tutorialImages : calibrationImages
            pageControl.numberOfPages = orderedImages.count
        }
    }

    func setupBackground() {
        for i in 0..<orderedImages.count {
            let imageView = UIView(frame: CGRect(x: CGFloat(i)*view.frame.width,
                                                 y: 0,
                                                 width: view.frame.width,
                                                 height: view.frame.height))
            imageView.addSubview(UIImageView(image: orderedImages[i]))
            scrollView.addSubview(imageView)

        }
    }

    func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(orderedImages.count), height: view.frame.height)
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
        go(to: pageControl.currentPage - 1)
    }


    @IBAction func didPressNext(_ sender: Any) {
        pageControl.currentPage == pageControl.numberOfPages - 1 ?
            done() :
            go(to: pageControl.currentPage + 1)
    }

    private func done() {
        dismiss(animated: true, completion: nil)
    }

    func go(to page: Int) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(page)*view.frame.width, y: 0), animated: true)
    }

}

// MARK: - UIScrollViewDelegate

extension TutorialViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/view.frame.width
        pageControl.currentPage = Int(page)
        reevaluateLayout()
    }

}

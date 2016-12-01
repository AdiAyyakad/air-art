//
//  TutorialPageViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 11/30/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    weak var tutorialViewController: TutorialViewController!
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

extension TutorialPageViewController {

    func setup() {
        if let bool = isTutorial {
            orderedImages = bool ? tutorialImages : calibrationImages
        }
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
            scrollView.addSubview(imageView)

        }
    }

}

// MARK: Page Actions

extension TutorialPageViewController {

    func done() {
        dismiss(animated: true, completion: nil)
    }

    func go(to page: Int) {

    }

}

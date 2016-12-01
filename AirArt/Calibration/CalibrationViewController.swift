//
//  CalibrationViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 11/30/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class CalibrationViewController: UIViewController {

    weak var pageViewController: TutorialPageViewController!

    @IBAction func didPressNext(_ sender: Any) {
        pageViewController.next(from: 0)
    }

    @IBAction func didPressPrev(_ sender: Any) {
        pageViewController.prev(from: 1)
    }

    @IBAction func didPressDone(_ sender: Any) {
        pageViewController.done()
    }

}

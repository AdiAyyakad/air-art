//
//  TutorialViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 11/30/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

enum TutorialButtonRestorationIdentifiers: String {
    case FirstNext = "First Next"
    case SecondNext = "Second Next"
    case SecondPrev = "Second Prev"
    case ThirdPrev = "Third Prev"
    case ThirdDone = "Third Done"
}

enum TutorialPageNum: Int {
    case First = 0
    case Second = 1
    case Third = 2
}

class TutorialViewController: UIViewController {

    weak var pageViewController: TutorialPageViewController!

    @IBAction func didPressPrev(_ sender: Any) {
        guard let btn = sender as? UIButton else {
            return
        }

        pageViewController.prev(from:
            btn.restorationIdentifier == TutorialButtonRestorationIdentifiers.SecondPrev.rawValue ?
                TutorialPageNum.Second.rawValue :
                TutorialPageNum.Third.rawValue)
    }


    @IBAction func didPressNext(_ sender: Any) {
        guard let btn = sender as? UIButton else {
            return
        }

        pageViewController.next(from:
            btn.restorationIdentifier == TutorialButtonRestorationIdentifiers.FirstNext.rawValue ?
                TutorialPageNum.First.rawValue :
                TutorialPageNum.Second.rawValue)
    }

    @IBAction func didPressDone(_ sender: Any) {
        pageViewController.done()
    }

}

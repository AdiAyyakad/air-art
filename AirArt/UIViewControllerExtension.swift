//
//  ArtViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/5/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentTutorial() {
        guard let tvc = initialize(isTutorial: true) else {
            DLog("\(#file) \(#line): Failed to initialize calibration")
            return
        }

        present(tvc, animated: true, completion: nil)
    }

    func presentCalibration() {
        guard let cvc = initialize(isTutorial: false) else {
            DLog("Failed to initialize calibration")
            return
        }

        present(cvc, animated: true, completion: nil)
    }

    private func initialize(isTutorial: Bool) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)

        guard let tvc = storyboard.instantiateInitialViewController() as? TutorialViewController else {
            return nil
        }

        tvc.isTutorial = isTutorial
        return tvc
    }

}
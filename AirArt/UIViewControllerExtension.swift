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
        guard let tvc = initializeTutorial() else {
            DLog("\(#file) \(#line): Failed to initialize calibration")
            return
        }

        present(tvc, animated: true, completion: nil)
    }

    private func initializeTutorial() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)

        return storyboard.instantiateInitialViewController()
    }

}

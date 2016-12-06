//
//  MainViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/5/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var happenOnce: Bool = true

    @IBAction func didPressTutorial(_ sender: Any) {
        presentTutorial()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Will happen just once

        if happenOnce {
            // I did not want to restructure your code, so I created a workaround
            presentTutorial()
            happenOnce = false
        } else {
            // Allowing us to view tutorial for the first time then present the sketch view if they
            // Select "Skip" or "Done"

            presentSketchView()
        }
    }

}

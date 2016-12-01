//
//  MainViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/1/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

enum SegueIdentifier: String {
    case Tutorial = "Tutorial Segue"
    case Calibration = "Calibration Segue"
    case Embed = "Embed Page View Controller Segue"
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tvc = segue.destination as? TutorialViewController,
                let id = segue.identifier else {
            return
        }

        switch id {
        case SegueIdentifier.Tutorial.rawValue:
            tvc.isTutorial = true
        case SegueIdentifier.Calibration.rawValue:
            tvc.isTutorial = false
        default:
            tvc.isTutorial = nil
        }
    }

}

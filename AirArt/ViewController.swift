//
//  ViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 9/24/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit
import MotionKit

class ViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!

    let motion = MotionKit()
    var calibratedPoint = Point(x: 0.0, y: 0.0, z: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        calibrate()
        startGettingPoints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Actions

extension ViewController {

    @IBAction func didPressCalibrate(_ sender: AnyObject) {
        calibrate()
    }

}

// MARK: - MotionKitHelpers

extension ViewController: MotionKitDelegate {

    func calibrate() {

        motion.stopDeviceMotionUpdates()

        startGettingPoints()

    }

    func startGettingPoints() {

        motion.getDeviceMotionObject { [unowned self] data in

            let acceleration = data.userAcceleration
            let x = Int(100*acceleration.x)
            let y = Int(100*acceleration.y)
            let z = Int(100*acceleration.z)

            print("Acceleration x: \(x), y: \(y), z: \(z)")
            print("------------------------------------------------------------------------------------------------------------")

            let constant = 5

            let dataTextX = x < -constant ? "Left" : x > constant ? "Right" : "NoneX"
            let dataTextY = y < -constant ? "Down" : y > constant ? "Up" : "NoneY"
            let dataTextZ = z < -constant ? "Back" : z > constant ? "Front" : "NoneZ"

            DispatchQueue.main.async { [unowned self] in
                self.dataLabel.text = "\(dataTextX) \(dataTextY) \(dataTextZ)"
            }

        }

    }

}

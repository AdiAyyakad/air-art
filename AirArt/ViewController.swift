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
        startGettingAccelerometerValues()
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

extension ViewController {

    func calibrate() {

        motion.stopAccelerometerUpdates()

        motion.getAccelerationAtCurrentInstant { [unowned self] (x, y, z) in
            self.calibratedPoint = Point(x: x, y: y, z: z)

            print("Calibrated to " + self.calibratedPoint.description)
        }

        startGettingAccelerometerValues()

    }

    func startGettingAccelerometerValues() {

        motion.getAccelerometerValues(0.1) { [unowned self] (x, y, z) in

            let dataString = "(\(x-self.calibratedPoint.x), \(y-self.calibratedPoint.y), \(z-self.calibratedPoint.z))"

            print(dataString)

            let point = Point(x: x, y: y, z: z)
            var horizontalDataString = ""

            if self.calibratedPoint.horizontalChange(from: point) > 0.1 {
                horizontalDataString = "Right"
            } else if self.calibratedPoint.horizontalChange(from: point) < -0.1 {
                horizontalDataString = "Left"
            } else {
                horizontalDataString = "No horizontal change"
            }

            var verticalDataString = ""

            if self.calibratedPoint.horizontalChange(from: point) > 0.1 {
                verticalDataString = "Up"
            } else if self.calibratedPoint.horizontalChange(from: point) < -0.1 {
                verticalDataString = "Down"
            } else {
                verticalDataString = "No vertical change"
            }

            DispatchQueue.main.async { [unowned self] in
                self.dataLabel.text = horizontalDataString + " " + verticalDataString
            }

        }

    }

}

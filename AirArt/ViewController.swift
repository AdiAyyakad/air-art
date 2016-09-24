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

        motion.getAccelerometerValues(1.0) { [unowned self] (x, y, z) in

            let dataString = "(\(x-self.calibratedPoint.x), \(y-self.calibratedPoint.y), \(z-self.calibratedPoint.z))"

            print(dataString)

            DispatchQueue.main.async { [unowned self] in
                self.dataLabel.text = dataString
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressCalibrate(_ sender: AnyObject) {
        calibrate()
    }
    
    func calibrate() {
        
        motion.getAccelerationAtCurrentInstant { [unowned self] (x, y, z) in
            self.calibratedPoint = Point(x: x, y: y, z: z)
            
            print("Calibrated to " + self.calibratedPoint.description)
        }

    }

}

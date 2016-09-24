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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        motion.getAccelerometerValues(1.0) { [unowned self] (x, y, z) in

            self.dataLabel.text = "\(x), \(y), \(z)"
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//
//  Path.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/6/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

struct Path {
    var cgPath: CGMutablePath
    var paint: Paint
    var layer: CAShapeLayer

    func addLine(to point: CGPoint) {
        cgPath.addLine(to: point)
        layer.path = cgPath
    }
}

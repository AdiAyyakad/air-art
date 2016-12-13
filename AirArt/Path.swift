//
//  Path.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/6/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

struct Path: Hashable, Equatable {
    var uiBezierPath: UIBezierPath
    var paint: Paint
    var layer: CAShapeLayer

    var hashValue: Int {
        return uiBezierPath.hashValue
    }

    static func == (lhs: Path, rhs: Path) -> Bool {
        return lhs.paint == rhs.paint && lhs.uiBezierPath == rhs.uiBezierPath && lhs.layer == rhs.layer
    }

    func addLine(to point: CGPoint) {
        uiBezierPath.addLine(to: point)
        layer.path = uiBezierPath.cgPath
    }
}

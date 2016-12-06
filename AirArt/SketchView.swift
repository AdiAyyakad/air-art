//
//  SketchView.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/6/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class SketchView: UIView {
    var paths: [UIBezierPath] = []
    var paints: [Paint] = []

    override func draw(_ rect: CGRect) {
        for i in 0..<paths.count {
            let path = paths[i]
            let paint = paints[i]

            paint.uiColor.setStroke()
            path.lineWidth = paint.brushSize
            path.stroke()
        }
    }

    func add(path: UIBezierPath, paint: Paint) {
        paths.append(path)
        paints.append(Paint(paint: paint))
    }

}

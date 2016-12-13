//
//  SketchView.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/6/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class SketchView: UIView {
    var paths: [Path] = []
    var undonePaths: [Path] = []
}

extension SketchView {

    func add(path: UIBezierPath, paint: Paint) -> Path {
        if !undonePaths.isEmpty {
            undonePaths = []
        }

        let bezier = CAShapeLayer()

        bezier.path = path.cgPath
        bezier.lineCap = kCALineCapRound
        bezier.lineWidth = paint.brushSize
        bezier.fillColor = UIColor.clear.cgColor
        bezier.strokeColor = paint.cgColor

        bezier.strokeStart = 0.0
        bezier.strokeEnd = 1.0

        layer.addSublayer(bezier)

        let pathStruct = Path(uiBezierPath: path, paint: Paint(paint: paint), layer: bezier)
        paths.append(pathStruct)

        return pathStruct
    }

    func undo() {
        guard let last = paths.popLast() else {
            return
        }

        undonePaths.append(last)
        last.layer.removeFromSuperlayer()
    }

    func redo() {
        guard let last = undonePaths.popLast() else {
            return
        }

        paths.append(last)
        layer.addSublayer(last.layer)
    }

    func clear() {
        layer.sublayers = []
        paths = []
    }

}

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

    override func draw(_ rect: CGRect) {
        for pathStruct in paths {
            let path = pathStruct.uiBezierPath
            let paint = pathStruct.paint

            paint.uiColor.setStroke()
            path.lineWidth = paint.brushSize
            path.stroke()
        }
    }
}

extension SketchView {

    func add(path: UIBezierPath, paint: Paint) {
        if !undonePaths.isEmpty {
            undonePaths = []
        }

        paths.append(Path(uiBezierPath: path, paint: Paint(paint: paint)))
    }

    func undo() {
        guard let last = paths.popLast() else {
            return
        }

        undonePaths.append(last)
        setNeedsDisplay()
    }

    func redo() {
        guard let last = undonePaths.popLast() else {
            return
        }

        paths.append(last)
        setNeedsDisplay()
    }

}

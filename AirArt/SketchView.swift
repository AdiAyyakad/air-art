//
//  SketchView.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/6/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class SketchView: UIView {
    var path: UIBezierPath!
    var paint: Paint { return Paint.currentPaint }

    override func draw(_ rect: CGRect) {
        paint.uiColor.setStroke()
        path.lineWidth = paint.brushSize
        path.stroke()
    }

}

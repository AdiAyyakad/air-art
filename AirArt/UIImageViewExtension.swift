//
//  UIImageViewExtension.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/7/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

extension UIImageView {

    func updatePreview() {
        var paint: Paint { return Paint.currentPaint }

        UIGraphicsBeginImageContext(frame.size)

        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }

        image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        context.clear(CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))

        // Draw the squiggle
        let numPoints = 20
        let sx = frame.width/5
        let sy = frame.height/2.0
        var x = 0.0
        var y = 0.0
        context.move(to: CGPoint(x:sx, y:sy))

        for index in 1...numPoints {
            x = Double(sx)+Double(index)/Double(numPoints)*3.0*Double(self.frame.width/5.0)
            y = Double(sy)+50.0*sin(Double(index)*2.0*M_PI/Double(numPoints))
            context.addLine(to: CGPoint(x: x, y: y))
        }

        context.setLineCap(.round)
        context.setLineWidth(paint.brushSize)
        context.setStrokeColor(paint.cgColor)
        context.setBlendMode(.normal)

        context.strokePath()
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        self.alpha = paint.alpha

        UIGraphicsEndImageContext()
    }

}

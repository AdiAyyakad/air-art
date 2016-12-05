//
//  BrushPreview.swift
//  AirArt
//
//  Created by Mark Creamer on 12/4/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import Foundation
import UIKit

class BrushPreview: UIImageView {
    var paint: Paint { return Paint.currentPaint }
    
    // Given the set Paint configuration, displays a sample stroke
    func update() {
        UIGraphicsBeginImageContext(self.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }
        self.image?.draw(in: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        context.clear(CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        
        // Draw the squiggle
        let numPoints = 20
        let sx = self.frame.width/5
        let sy = self.frame.height/2.0
        var x = 0.0
        var y = 0.0
        context.move(to: CGPoint(x:sx,y:sy))
        for index in 1...numPoints {
            x = Double(sx)+Double(index)/Double(numPoints)*3.0*Double(self.frame.width/5.0)
            y = Double(sy)+50.0*sin(Double(index)*2.0*M_PI/Double(numPoints))
            context.addLine(to: CGPoint(x: x,y: y))
        }
        
        context.setLineCap(.round)
        context.setLineWidth(paint.brushSize)
        context.setStrokeColor(paint.getUIColor().cgColor)
        context.setBlendMode(.normal)
        
        context.strokePath()
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        self.alpha = paint.alpha
        
        UIGraphicsEndImageContext()
    }
}

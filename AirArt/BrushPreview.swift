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
        context.move(to: CGPoint(x:self.frame.width/5,y:self.frame.height/2.0))
        context.addLine(to: CGPoint(x:4*self.frame.width/5,y:self.frame.height/2.0))
        
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

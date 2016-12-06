//
//  Paint.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/1/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

struct Paint: Equatable {
    public static var currentPaint: Paint = Paint(red: 0, green: 0, blue: 0, alpha: 1.0, brushSize: 10.0)

    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    var brushSize: CGFloat

    var uiColor: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    var cgColor: CGColor {
        return uiColor.cgColor
    }

    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat, brushSize: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
        self.brushSize = brushSize
    }

    init(paint: Paint) {
        self.red = paint.red
        self.green = paint.green
        self.blue = paint.blue
        self.alpha = paint.alpha
        self.brushSize = paint.brushSize
    }

    public static func == (lhs: Paint, rhs: Paint) -> Bool {
        return lhs.red == rhs.red && lhs.green == rhs.green && lhs.blue == rhs.blue && lhs.alpha == rhs.alpha && lhs.brushSize == rhs.brushSize
    }
}

//
//  Paint.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/1/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

struct Paint {
    public static var currentPaint: Paint = Paint(red: 0, green: 0, blue: 0, alpha: 1.0, brushSize: 10.0)

    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    var brushSize: CGFloat

    func getUIColor() -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

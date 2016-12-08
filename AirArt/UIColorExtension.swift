//
//  UIColorExtension.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/8/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

extension UIColor {

    /**
     Index 0 = red;
     Index 1 = green;
     Index 2 = blue;
     Index 3 = alpha;
     */
    func getRGBComponents() -> [CGFloat] {
        var red: CGFloat = -1.0
        var green: CGFloat = -1.0
        var blue: CGFloat = -1.0
        var alpha: CGFloat = -1.0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return [red, green, blue, alpha]
    }

    /**
     Index 0 = hue;
     Index 1 = saturation;
     Index 2 = brightness;
     Index 3 = alpha;
     */
    func getHSBComponents() -> [CGFloat] {
        var hue: CGFloat = -1.0
        var sat: CGFloat = -1.0
        var bright: CGFloat = -1.0
        var alpha: CGFloat = -1.0

        getHue(&hue, saturation: &sat, brightness: &bright, alpha: &alpha)

        return [hue, sat, bright, alpha]
    }

}

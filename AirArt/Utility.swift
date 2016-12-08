//
//  Utility.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/8/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

struct Utility {
    static func clamp(_ value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        return min > value ? min : max < value ? max : value
    }
}

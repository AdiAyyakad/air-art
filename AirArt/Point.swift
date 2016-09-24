//
//  Point.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 9/24/16.
//  Copyright © 2016 Adi. All rights reserved.
//

struct Point {

    var x: Double
    var y: Double
    var z: Double

    var description: String {
        return "(\(x), \(y), \(z))"
    }

    func horizontalChange(from point: Point) -> Double {
        return x - point.x
    }

    func verticalChange(from point: Point) -> Double {
        return y - point.y
    }

}

//
//  HSLColorView.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/8/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

@IBDesignable
class HSColorView: HSBView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

}

// MARK: - Gesture Recognizers

extension HSColorView {

    override func recognize(_ gesture: UIGestureRecognizer) {
        let point = gesture.location(in: self)
        currentColor = getColor(at: CGPoint(x: Utility.clamp(point.x, min: 0, max: bounds.width),
                                            y: Utility.clamp(point.y, min: 0, max: bounds.height)))
    }

}

// MARK: - Helpers

extension HSColorView {

    func getPoint(from color: UIColor) -> CGPoint? {

        var hue: CGFloat = -1.0
        var sat: CGFloat = -1.0

        color.getHue(&hue,
                     saturation: &sat,
                     brightness: nil,
                     alpha: nil)


        return hue == -1.0 || sat == -1.0 ? nil : CGPoint(x: hue * frame.maxX, y: sat * frame.maxY)
    }

    func getColor(at point: CGPoint) -> UIColor {

        return UIColor(hue: point.x/frame.maxX,
                       saturation: point.y/frame.maxY,
                       brightness: brightness,
                       alpha: alpha)

    }

}

// MARK: - Draw

extension HSColorView {

    override func draw(_ rect: CGRect) {
        createHSL()
        createCrosshairs()?.stroke()
    }

    /**
     Creates the actual background of HSL generated colors
     */
    private func createHSL() {
        guard let context = UIGraphicsGetCurrentContext() else {
            DLog("Could not get current context")
            return
        }

        for hue in 0..<Int(bounds.maxX) {
            for sat in 0..<Int(bounds.maxY) {
                UIColor(hue: CGFloat(hue)/bounds.maxX,
                        saturation: CGFloat(sat)/bounds.maxY,
                        brightness: brightness,
                        alpha: colorAlpha).setFill()

                context.fill(CGRect(x: hue, y: sat, width: 1, height: 1))
            }
        }
    }

    /**
     Creates a crosshairs as follows:

                   |
                   |
             ______|______
            /      |      \
           /       |       \
          |        |        |
          |        |        |
     -----------------------------
          |        |        |
          |        |        |
           \       |       /
            \______|______/
                   |
                   |
                   |

    More or less
     */
    private func createCrosshairs() -> UIBezierPath? {
        guard let currentColorPoint = getPoint(from: currentColor) else {
            DLog("Could not get point from current color")
            return nil
        }

        let size = frame.width/20
        let crosshairsFrame = CGRect(x: currentColorPoint.x - size/2,
                                     y: currentColorPoint.y - size/2,
                                     width: size,
                                     height: size)

        // circle
        let crosshairs = UIBezierPath(ovalIn: crosshairsFrame)
        crosshairs.lineWidth = 2.0

        // top of the cross
        crosshairs.move(to: CGPoint(x: crosshairsFrame.midX, y: crosshairsFrame.midY-size))
        crosshairs.addLine(to: CGPoint(x: crosshairsFrame.midX, y: crosshairsFrame.midY + size))

        // bottom of cross
        crosshairs.move(to: CGPoint(x: crosshairsFrame.midX-size, y: crosshairsFrame.midY))
        crosshairs.addLine(to: CGPoint(x: crosshairsFrame.midX + size, y: crosshairsFrame.midY))

        return crosshairs
    }

}

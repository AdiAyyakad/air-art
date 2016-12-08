//
//  HSLColorView.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/8/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

@IBDesignable
class HSLColorView: UIView {

    @IBInspectable internal var currentColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    internal var brightness: CGFloat = 1.0
    internal var colorAlpha: CGFloat = 1.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

}

// MARK: - Setup

private extension HSLColorView {

    func setup() {
        setupGestureRecognizers()
    }

    private func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(recognize(_:)))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(recognize(_:)))
        addGestureRecognizer(tap)
        addGestureRecognizer(pan)
    }
}

// MARK: - Gesture Recognizers

extension HSLColorView {

    func recognize(_ gesture: UIGestureRecognizer) {
        let point = gesture.location(in: self)
        currentColor = getColor(at: point)
    }

}

// MARK: - Accessors

extension HSLColorView {

    func changeBrightness(to newBrightness: CGFloat) {
        brightness = newBrightness
        reevaluateCurrentColor()
    }

    func changeColorAlpha(to newColorAlpha: CGFloat) {
        colorAlpha = newColorAlpha
        reevaluateCurrentColor()
    }

    private func reevaluateCurrentColor() {
        var hue: CGFloat = -1.0
        var sat: CGFloat = -1.0
        var bright: CGFloat = -1.0
        var alph: CGFloat = -1.0

        currentColor.getHue(&hue, saturation: &sat, brightness: &bright, alpha: &alph)
        currentColor = UIColor(hue: hue, saturation: sat, brightness: bright, alpha: alph)
    }

}

// MARK: - Helpers

extension HSLColorView {

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

extension HSLColorView {

    override func draw(_ rect: CGRect) {
        createHSL()
        createCrosshairs()?.stroke()
    }

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

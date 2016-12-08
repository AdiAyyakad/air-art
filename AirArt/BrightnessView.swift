//
//  BrightnessView.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/8/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

@IBDesignable
class BrightnessView: UIView {

    @IBInspectable internal var brightness: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    internal var currentColor: UIColor = .white
    internal var gradientWidth: Int { return Int(bounds.width / 2) }
    internal let padding: CGFloat = 8

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

private extension BrightnessView {

    func setup() {
        setupBackground()
        setupGestureRecognizers()
    }

    func setupBackground() {
        backgroundColor = .clear
    }

    func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(recognize(_:)))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(recognize(_:)))
        addGestureRecognizer(tap)
        addGestureRecognizer(pan)
    }

}

// MARK: - Gesture Recgonizer

internal extension BrightnessView {

    func recognize(_ gesture: UIGestureRecognizer) {
        let rowTouched = gesture.location(in: self).y
        changeBrightness(to: rowTouched / bounds.height)
    }

}

// MARK: - Helper

internal extension BrightnessView {

    func getPoint(from brightness: CGFloat) -> CGPoint {
        return CGPoint(x: CGFloat(gradientWidth) + padding, y: bounds.height - (brightness * bounds.height))
    }

}

// MARK: - Accessors

extension BrightnessView {

    func changeBrightness(to newBrightness: CGFloat) {
        brightness = newBrightness
    }

}

// MARK: - Draw

internal extension BrightnessView {

    override func draw(_ rect: CGRect) {
        drawGradient()

        let pointer = createPointer(to: getPoint(from: brightness))

        UIColor.lightGray.setFill()
        pointer.fill()

        UIColor.darkGray.setStroke()
        pointer.stroke()
    }

    private func drawGradient() {
        guard let context = UIGraphicsGetCurrentContext() else {
            DLog("Could not get current context")
            return
        }

        var hue: CGFloat = -1.0
        var sat: CGFloat = -1.0
        var alph: CGFloat = -1.0

        currentColor.getHue(&hue, saturation: &sat, brightness: nil, alpha: &alph)

        // Iterate through the brightness values
        for bright in 0..<Int(bounds.height) {
            UIColor(hue: hue,
                    saturation: sat,
                    brightness: CGFloat(bright) / bounds.height,
                    alpha: alph).setFill()

            context.fill(CGRect(x: 0, y: Int(bounds.height) - bright, width: gradientWidth, height: 1))
        }
    }

    /**
     Creates the following "pointer" with the verticies labelled as follows:

            Top Left Box    Top Right Box
                 _____________
                /            |
               /             |
              /              |
             / Point         |
             \               |
              \              |
               \             |
                \____________|
          Bottom Left Box   Bottom Right Box

      More or less
     */
    private func createPointer(to point: CGPoint) -> UIBezierPath {
        let pointer = UIBezierPath()
        let size: CGFloat = 6.0

        let topLeftBox = CGPoint(x: point.x + size, y: point.y + size)
        let topRightBox = CGPoint(x: topLeftBox.x + size*2, y: topLeftBox.y)
        let bottomLeftBox = CGPoint(x: point.x + size, y: point.y - size)
        let bottomRightBox = CGPoint(x: bottomLeftBox.x + size*2, y: bottomLeftBox.y)

        pointer.move(to: point)
        pointer.addLine(to: topLeftBox)
        pointer.addLine(to: topRightBox)
        pointer.addLine(to: bottomRightBox)
        pointer.addLine(to: bottomLeftBox)
        pointer.close()

        pointer.lineWidth = 2.0

        return pointer
    }

}

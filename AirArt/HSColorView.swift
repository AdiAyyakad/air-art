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

    let crosshairView = CrosshairView()

    override func setup() {
        super.setup()

        addSubview(crosshairView)
    }

}

// MARK: - Action

extension HSColorView {

    func updateCrosshairs() {
        let colorHue = Utility.clamp(hue * frame.width, min: 0, max: bounds.width)
        let colorSat = Utility.clamp(sat * frame.height, min: 0, max: bounds.height)

        crosshairView.move(to: CGPoint(x: colorHue, y: colorSat))
    }

}

// MARK: - Gesture Recognizers

extension HSColorView {

    override func recognize(_ gesture: UIGestureRecognizer) {
        let point = gesture.location(in: self)
        let clampedPoint = CGPoint(x: Utility.clamp(point.x, min: 0, max: bounds.width),
                                   y: Utility.clamp(point.y, min: 0, max: bounds.height))

        let newHue = clampedPoint.x / frame.width
        let newSat = clampedPoint.y / frame.height

        var update = false

        if newHue != hue {
            hue = newHue
            update = true
        }

        if newSat != sat {
            sat = newSat
            update = true
        }

        if update {
            updateCrosshairs()
        }
    }

}

// MARK: - Draw

extension HSColorView {

    override func draw(_ rect: CGRect) {
        DLog("Drawing HSColorView")
        createHSL()
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

}

class CrosshairView: UIView {

    var size: CGFloat = 13.0
    private var shapeLayer = CAShapeLayer()

    // MARK: - Inits

    convenience init() {
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: 13.0,
                                                            height: 13.0)))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: - Setup

    func setup() {
        move(to: CGPoint(x: size / 2, y: size / 2))
        setupLayer()
        layer.addSublayer(shapeLayer)
    }

    func setupLayer() {
        shapeLayer.path = createCrosshairs().cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.fillColor = UIColor.clear.cgColor
    }

    // MARK: - Action

    func move(to point: CGPoint, animated: Bool = false) {
        if animated {
            UIView.animate(withDuration: 0.1,
                           delay: 0.0,
                           options: .curveEaseInOut,
                           animations: { [unowned self] in
                            self.center = point
            }, completion: nil)

            UIView.commitAnimations()
        } else {
            center = point
        }

        let components = Paint.currentPaint.uiColor.getRGBComponents()
        let one: CGFloat = 1.0

        shapeLayer.strokeColor = UIColor(red: one-components[0],
                                         green: one-components[1],
                                         blue: one-components[2],
                                         alpha: 1.0).cgColor
    }

    // MARK: - UIBezierPath Creator

    private func createCrosshairs() -> UIBezierPath {
        // circle
        let crosshairs = UIBezierPath(ovalIn: bounds)

        // top of the cross
        crosshairs.move(to: CGPoint(x: center.x, y: center.y - size))
        crosshairs.addLine(to: CGPoint(x: center.x, y: center.y + size))

        // bottom of cross
        crosshairs.move(to: CGPoint(x: center.x - size, y: center.y))
        crosshairs.addLine(to: CGPoint(x: center.x + size, y: center.y))

        return crosshairs
    }

}

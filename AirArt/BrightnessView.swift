//
//  BrightnessView.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/8/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

@IBDesignable
class BrightnessView: HSBView {

    var gradientWidth: Int { return Int(bounds.width / 2) }
    var padding: CGFloat { return superHSBColorPickerView.padding }
    let pointerView = PointerView()

    override func setup() {
        super.setup()

        addSubview(pointerView)
        pointerView.move(center: CGPoint(x: CGFloat(gradientWidth) + padding, y: bounds.height))
    }

}

// MARK: - Action

extension BrightnessView {

    func updatePointer() {
        pointerView.move(to: (1 - brightness) * bounds.height)
    }

}

// MARK: - Gesture Recgonizer

extension BrightnessView {

    override func recognize(_ gesture: UIGestureRecognizer) {
        let rowTouched = Utility.clamp(gesture.location(in: self).y, min: 0, max: bounds.height)
        brightness = 1 - (rowTouched / bounds.height)

        updatePointer()
    }

}

// MARK: - Draw

extension BrightnessView {

    override func draw(_ rect: CGRect) {
        DLog("Drawing Brightness")
        drawGradient()
    }

    private func drawGradient() {
        guard let context = UIGraphicsGetCurrentContext() else {
            DLog("Could not get current context")
            return
        }

        // Iterate through the brightness values
        for iBrightness in 0..<Int(bounds.height) {
            UIColor(hue: hue,
                    saturation: sat,
                    brightness: CGFloat(iBrightness) / bounds.height,
                    alpha: colorAlpha).setFill()

            context.fill(CGRect(x: 0, y: Int(bounds.height) - iBrightness, width: gradientWidth, height: 1))
        }
    }

}

class PointerView: UIView {
    public static let size: CGFloat = 6.0

    // MARK: - Inits

    convenience init() {
        self.init(frame: CGRect(origin: .zero,
                                size: CGSize(width: PointerView.size,
                                height: PointerView.size)))
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
        center = .zero

        let pointerLayer = CAShapeLayer()

        pointerLayer.path = createPointer().cgPath
        pointerLayer.fillColor = UIColor.lightGray.cgColor
        pointerLayer.strokeColor = UIColor.darkGray.cgColor
        pointerLayer.lineWidth = 2.0

        layer.addSublayer(pointerLayer)
    }

    // MARK: - Action

    func move(to y: CGFloat) {
        center.y = y
    }

    func move(center toPoint: CGPoint) {
        center = toPoint
    }

    // MARK: - UIBezierPath

    private func createPointer() -> UIBezierPath {
        let pointer = UIBezierPath()

        let topLeftBox = CGPoint(x: center.x + PointerView.size, y: center.y + PointerView.size)
        let topRightBox = CGPoint(x: topLeftBox.x + PointerView.size * 2, y: topLeftBox.y)
        let bottomLeftBox = CGPoint(x: center.x + PointerView.size, y: center.y - PointerView.size)
        let bottomRightBox = CGPoint(x: bottomLeftBox.x + PointerView.size * 2, y: bottomLeftBox.y)

        pointer.move(to: center)
        pointer.addLine(to: topLeftBox)
        pointer.addLine(to: topRightBox)
        pointer.addLine(to: bottomRightBox)
        pointer.addLine(to: bottomLeftBox)
        pointer.close()

        return pointer
    }
}

//
//  HSLBColorPickerView.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/8/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

// @IBDesignable
class HSBColorPickerView: UIView {

    @IBInspectable internal var color: UIColor = .purple {
        didSet {
            delegate?.colorDidChange(to: color)

            hsColorView.updateCrosshairs()
            brightnessView.updatePointer()
        }
    }

    var hue: CGFloat = 1.0 {
        didSet {
            color = UIColor(hue: hue, saturation: sat, brightness: brightness, alpha: colorAlpha)
            brightnessView.setNeedsDisplay()
        }
    }

    var sat: CGFloat = 1.0 {
        didSet {
            color = UIColor(hue: hue, saturation: sat, brightness: brightness, alpha: colorAlpha)
            brightnessView.setNeedsDisplay()
        }
    }

    var brightness: CGFloat = 1.0 {
        didSet {
            color = UIColor(hue: hue, saturation: sat, brightness: brightness, alpha: colorAlpha)
            hsColorView.setNeedsDisplay()
        }
    }

    let colorAlpha: CGFloat = 1.0

    var delegate: HSBColorPickerViewDelegate?
    var hsColorView: HSColorView!
    var brightnessView: BrightnessView!

    let brightnessScale: CGFloat = 0.2
    let padding: CGFloat = 16

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

 extension HSBColorPickerView {

    func setup() {
        setupBackground()
        populateSubviews()
    }

    func setupBackground() {
        backgroundColor = .clear
    }

    func populateSubviews() {
        let hsColorViewFrame = CGRect(origin: .zero,
                                      size: CGSize(width: (bounds.width * (1 - brightnessScale)) - (padding / 2),
                                                   height: bounds.height))
        let brightnessViewFrame = CGRect(x: hsColorViewFrame.maxX + padding,
                                         y: 0,
                                         width: (bounds.width * brightnessScale) - (padding / 2),
                                         height: bounds.height)

        hsColorView = HSColorView(frame: hsColorViewFrame, superview: self)
        brightnessView = BrightnessView(frame: brightnessViewFrame, superview: self)

        hsColorView.superHSBColorPickerView = self
        brightnessView.superHSBColorPickerView = self

        insertSubview(hsColorView, belowSubview: self)
        insertSubview(brightnessView, belowSubview: hsColorView)
    }

}

protocol HSBColorPickerViewDelegate {

    func colorDidChange(to color: UIColor)

}

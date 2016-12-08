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

    @IBInspectable var color: UIColor = .purple {
        didSet {
            delegate?.colorDidChange(to: color)
            setNeedsDisplay()
        }
    }

    var brightness: CGFloat = 1.0 {
        didSet {
            var hue: CGFloat = -1.0
            var sat: CGFloat = -1.0
            var alpha: CGFloat = -1.0

            color.getHue(&hue, saturation: &sat, brightness: nil, alpha: &alpha)

            color = UIColor(hue: hue, saturation: sat, brightness: brightness, alpha: alpha)
        }
    }

    var colorAlpha: CGFloat = 1.0 {
        didSet {
            var hue: CGFloat = -1.0
            var sat: CGFloat = -1.0
            var bright: CGFloat = -1.0

            color.getHue(&hue, saturation: &sat, brightness: &bright, alpha: nil)

            color = UIColor(hue: hue, saturation: sat, brightness: bright, alpha: colorAlpha)
        }
    }

    var delegate: HSBColorPickerViewDelegate?
    let brightnessScale: CGFloat = 0.2
    let padding: CGFloat = 8

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

        let hsColorView = HSColorView(frame: hsColorViewFrame)
        let brightnessView = BrightnessView(frame: brightnessViewFrame)

        hsColorView.superHSBColorPickerView = self
        brightnessView.superHSBColorPickerView = self

        insertSubview(hsColorView, belowSubview: self)
        insertSubview(brightnessView, belowSubview: hsColorView)
    }

}

// MARK: - SetNeedsDisplay

extension HSBColorPickerView {

    override func setNeedsDisplay() {
        super.setNeedsDisplay()

        for sbv in subviews {
            sbv.setNeedsDisplay()
        }
    }

}

protocol HSBColorPickerViewDelegate {

    func colorDidChange(to color: UIColor)

}

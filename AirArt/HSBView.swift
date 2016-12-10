//
//  HSBView.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/8/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class HSBView: UIView {

    weak var superHSBColorPickerView: HSBColorPickerView!
    var hue: CGFloat {
        get {
            return superHSBColorPickerView.hue
        }

        set {
            superHSBColorPickerView.hue = newValue
        }
    }
    var sat: CGFloat {
        get {
            return superHSBColorPickerView.sat
        }

        set {
            superHSBColorPickerView.sat = newValue
        }
    }
    var brightness: CGFloat {
        get {
            return superHSBColorPickerView.brightness
        }

        set {
            superHSBColorPickerView.brightness = newValue
        }
    }
    var colorAlpha: CGFloat { return superHSBColorPickerView.colorAlpha }

    var currentColor: UIColor {
        get {
            return superHSBColorPickerView.color
        }

        set {
            superHSBColorPickerView.color = newValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, superview superHSBColorPickerView: HSBColorPickerView) {
        self.init(frame: frame)

        self.superHSBColorPickerView = superHSBColorPickerView
        setup()
    }

}

// MARK: - Setup

internal extension HSBView {

    func setup() {
        setupBackground()
        setupGestureRecognizers()
    }

    private func setupBackground() {
        backgroundColor = .clear
    }

    private func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(recognize(_:)))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(recognize(_:)))

        addGestureRecognizer(tap)
        addGestureRecognizer(pan)
    }

}

// MARK: - Gesture Recognizer

extension HSBView {

    func recognize(_ gesture: UIGestureRecognizer) {
        DLog("Recognized")
    }

}

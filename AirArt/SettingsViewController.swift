//
//  SettingsViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/1/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var brushSizeSlider: UISlider!
    @IBOutlet weak var previewView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        redSlider.value = Float(Paint.currentPaint.red)
        redSlider.addTarget(self, action: #selector(redDidChange), for: .valueChanged)

        greenSlider.value = Float(Paint.currentPaint.green)
        greenSlider.addTarget(self, action: #selector(greenDidChange), for: .valueChanged)

        blueSlider.value = Float(Paint.currentPaint.blue)
        blueSlider.addTarget(self, action: #selector(blueDidChange), for: .valueChanged)

        alphaSlider.value = Float(Paint.currentPaint.alpha)
        alphaSlider.addTarget(self, action: #selector(alphaDidChange), for: .valueChanged)

        brushSizeSlider.value = Float(Paint.currentPaint.brushSize)
        brushSizeSlider.addTarget(self, action: #selector(brushSizeDidChange), for: .valueChanged)
    }

}

// MARK: - Actions

extension SettingsViewController {

    @IBAction func didPressGo(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func redDidChange() {
        Paint.currentPaint.red = CGFloat(redSlider.value)
    }

    func greenDidChange() {
        Paint.currentPaint.green = CGFloat(greenSlider.value)
    }

    func blueDidChange() {
        Paint.currentPaint.blue = CGFloat(blueSlider.value)
    }

    func alphaDidChange() {
        Paint.currentPaint.alpha = CGFloat(alphaSlider.value)
    }

    func brushSizeDidChange() {
        Paint.currentPaint.brushSize = CGFloat(brushSizeSlider.value)
    }

    func updatePreview() {
        
    }

}

// MARK: - Segue

extension SettingsViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.Calibration.rawValue {
            guard let cvc = segue.destination as? TutorialViewController else {
                return
            }

            cvc.isTutorial = false
        }
    }

}

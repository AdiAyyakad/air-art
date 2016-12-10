//
//  SettingsTableViewController.swift
//  AirArt
//
//  Created by Michae Kalu on 12/6/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

enum ResuseIdentifier: String {
    case Tutorial = "Tutorial"
    case Calibration = "Calibrate"
}

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var previewImageView: BrushPreview!
    @IBOutlet weak var brushSizeSlider: UISlider!
    @IBOutlet weak var rgbHSBSegmentedControl: UISegmentedControl! // 0 is RGB, 1 is HSB

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var opacitySlider: UISlider!

    @IBOutlet weak var rgbView: UIStackView!
    @IBOutlet weak var hsbView: HSBColorPickerView!

    @IBOutlet weak var colorPreviewWindow: UIImageView!

    @IBOutlet weak var rgbLabel: UILabel!
    @IBOutlet weak var hexLabel: UILabel!

    /**
     * Used to keep track of previous color, in case the user wants
     * to dismiss their changes by clicking cancel.
     */
    var previousColor: Paint!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

// MARK: - Setup

extension SettingsTableViewController {

    func setup() {
        setupSliders()
        setupHSBView()

        // Update the brush preview
        update()

        // Save old color, in case
        previousColor = Paint(paint: Paint.currentPaint)
    }

    func setupSliders() {
        redSlider.value = Float(Paint.currentPaint.red)
        redSlider.addTarget(self, action: #selector(redDidChange), for: .valueChanged)

        greenSlider.value = Float(Paint.currentPaint.green)
        greenSlider.addTarget(self, action: #selector(greenDidChange), for: .valueChanged)

        blueSlider.value = Float(Paint.currentPaint.blue)
        blueSlider.addTarget(self, action: #selector(blueDidChange), for: .valueChanged)

        opacitySlider.value = Float(Paint.currentPaint.alpha)
        opacitySlider.addTarget(self, action: #selector(alphaDidChange), for: .valueChanged)

        brushSizeSlider.value = Float(Paint.currentPaint.brushSize)
        brushSizeSlider.addTarget(self, action: #selector(brushSizeDidChange), for: .valueChanged)
    }

    func setupHSBView() {
        hsbView.delegate = self
    }

}

// MARK: - UIBarButtonItem Action

extension SettingsTableViewController {

    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Are you sure you want to cancel?",
                                      message: "If you would like to keep your current paint settings, click Go. If not, click Yes",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes",
                                      style: .default,
                                      handler: { [unowned self] action in
                                        self.dismiss(animated: true) { [unowned self] in
                                            Paint.currentPaint = self.previousColor
                                        }
        }))

        alert.addCancelAction()

        present(alert, animated: true, completion: nil)
    }

    @IBAction func goButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension SettingsTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath),
            let id = cell.reuseIdentifier,
            id == ResuseIdentifier.Tutorial.rawValue {
            presentTutorial()
        }

        tableView.deselectRow(at: indexPath, animated: true)

    }
}

// MARK: - UISegmentedController Value Changed Action

extension SettingsTableViewController {

    @IBAction func didChangeValue(_ sender: UISegmentedControl) {
        rgbView.isHidden = rgbHSBSegmentedControl.selectedSegmentIndex == 1
        hsbView.isHidden = rgbHSBSegmentedControl.selectedSegmentIndex == 0

        if rgbView.isHidden {

            let components = Paint.currentPaint.uiColor.getHSBComponents()

            hsbView.hue = components[0]
            hsbView.sat = components[1]
            hsbView.brightness = components[2]

        } else {
            redSlider.value = Float(Paint.currentPaint.red)
            greenSlider.value = Float(Paint.currentPaint.green)
            blueSlider.value = Float(Paint.currentPaint.blue)
            opacitySlider.value = Float(Paint.currentPaint.alpha)
        }
    }

}

// MARK: - UISlider Value Changed Actions

extension SettingsTableViewController {

    func redDidChange() {
        Paint.currentPaint.red = CGFloat(redSlider.value)
        update()
    }

    func greenDidChange() {
        Paint.currentPaint.green = CGFloat(greenSlider.value)
        update()
    }

    func blueDidChange() {
        Paint.currentPaint.blue = CGFloat(blueSlider.value)
        update()
    }

    func alphaDidChange() {
        Paint.currentPaint.alpha = CGFloat(opacitySlider.value)
        update()
    }

    func brushSizeDidChange() {
        Paint.currentPaint.brushSize = CGFloat(brushSizeSlider.value)
        update()
    }
}

// MARK: - Helper

extension SettingsTableViewController {

    func update() {
        previewImageView.updatePreview()
        colorPreviewWindow.backgroundColor = Paint.currentPaint.uiColor

        let rgbComp = Paint.currentPaint.uiColor.getRGBComponents()
        let r = Int(rgbComp[0] * 255)
        let g = Int(rgbComp[1] * 255)
        let b = Int(rgbComp[2] * 255)
        let a = Int(rgbComp[3] * 255)

        rgbLabel.text = String(format: "rgba (%d, %d, %d, %.02f)", r, g, b, rgbComp[3])
        hexLabel.text = String(format:"0x%02X%02X%02X%02X", r, g, b, a)
    }

}

// MARK: - HSBColorPickerViewDelegate

extension SettingsTableViewController: HSBColorPickerViewDelegate {

    func colorDidChange(to color: UIColor) {
        Paint.currentPaint.uiColor = color
        update()
    }

}

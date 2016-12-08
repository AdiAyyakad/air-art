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
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var colorPreviewWindow: UIImageView!

    /**
     * Used to keep track of previous color, in case the user wants
     * to dismiss their changes by clicking cancel.
     */
    var previousColor: Paint!

    override func viewDidLoad() {
        super.viewDidLoad()

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

        // Update the brush preview
        previewImageView.updatePreview()
        colorPreviewWindow.backgroundColor = Paint.currentPaint.uiColor

        previousColor = Paint(paint: Paint.currentPaint)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Are you sure you want to cancel?", message: "If you would like to keep your current paint settings, click Go. If not, click Yes", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [unowned self] action in
            self.dismiss(animated: true) { [unowned self] in
                Paint.currentPaint = self.previousColor
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }

    @IBAction func goButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let cell = tableView.cellForRow(at: indexPath),
            let id = cell.reuseIdentifier else {
            return
        }

        switch id {
        case ResuseIdentifier.Calibration.rawValue:
            presentCalibration()

        case ResuseIdentifier.Tutorial.rawValue:
            presentTutorial()

        default:
            return

        }

    }

}


extension SettingsTableViewController {

    func redDidChange() {
        Paint.currentPaint.red = CGFloat(redSlider.value)
        previewImageView.updatePreview()
        colorPreviewWindow.backgroundColor = Paint.currentPaint.uiColor
    }

    func greenDidChange() {
        Paint.currentPaint.green = CGFloat(greenSlider.value)
        previewImageView.updatePreview()
        colorPreviewWindow.backgroundColor = Paint.currentPaint.uiColor
    }

    func blueDidChange() {
        Paint.currentPaint.blue = CGFloat(blueSlider.value)
        previewImageView.updatePreview()
        colorPreviewWindow.backgroundColor = Paint.currentPaint.uiColor
    }

    func alphaDidChange() {
        Paint.currentPaint.alpha = CGFloat(opacitySlider.value)
        previewImageView.updatePreview()
        colorPreviewWindow.backgroundColor = Paint.currentPaint.uiColor
    }

    func brushSizeDidChange() {
        Paint.currentPaint.brushSize = CGFloat(brushSizeSlider.value)
        previewImageView.updatePreview()
        colorPreviewWindow.backgroundColor = Paint.currentPaint.uiColor
    }

}

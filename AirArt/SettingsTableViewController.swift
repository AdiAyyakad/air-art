//
//  SettingsTableViewController.swift
//  AirArt
//
//  Created by Michae Kalu on 12/6/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var previewImageView: BrushPreview!
    @IBOutlet weak var brushSizeSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var colorPreviewWindow: UIImageView!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func goButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)

    }
//    @IBAction func goButtonPressed(_ sender: AnyObject) {
//        dismiss(animated: true, completion: nil)
//    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }

}

// MARK: - Actions

extension UIImageView {
    
    func updatePreview() {
        var paint: Paint { return Paint.currentPaint }
        
        UIGraphicsBeginImageContext(frame.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }
        
        image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        context.clear(CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        // Draw the squiggle
        let numPoints = 20
        let sx = frame.width/5
        let sy = frame.height/2.0
        var x = 0.0
        var y = 0.0
        context.move(to: CGPoint(x:sx, y:sy))
        
        for index in 1...numPoints {
            x = Double(sx)+Double(index)/Double(numPoints)*3.0*Double(self.frame.width/5.0)
            y = Double(sy)+50.0*sin(Double(index)*2.0*M_PI/Double(numPoints))
            context.addLine(to: CGPoint(x: x, y: y))
        }
        
        context.setLineCap(.round)
        context.setLineWidth(paint.brushSize)
        context.setStrokeColor(paint.cgColor)
        context.setBlendMode(.normal)
        
        context.strokePath()
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        self.alpha = paint.alpha
        
        UIGraphicsEndImageContext()
    }
}


extension SettingsTableViewController {
    
    @IBAction func didPressGo(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressRecalibrate(_ sender: Any) {
        presentCalibration()
    }
    
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

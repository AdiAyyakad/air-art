//
//  SketchViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/1/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreMotion

class SketchViewController: UIViewController {

    @IBOutlet weak var sketchView: SketchView!
    var path = UIBezierPath()
    let motionManager = CMMotionManager()
    var touch: CGPoint = .zero
    var initialXAccel: Double!
    var initialYAccel: Double!
    let scale = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMotion()
    }

}

// MARK: - Setup

extension SketchViewController {

    func setupMotion() {
        motionManager.accelerometerUpdateInterval = 0.2
    }

}

// MARK: - Accelerometer Data Handler

extension SketchViewController {

    func beginGettingData() {
        guard let queue = OperationQueue.current else {
            NSLog("No operation queue")
            return
        }

        DLog("Begin getting data")
        path = UIBezierPath()
        path.move(to: touch)
        path.lineCapStyle = .round

        sketchView.add(path: path, paint: Paint.currentPaint)

        motionManager.startAccelerometerUpdates(to: queue, withHandler: handler)
    }

    func endGettingData() {
        DLog("End getting data")
        initialXAccel = nil
        initialYAccel = nil

        motionManager.stopAccelerometerUpdates()
    }

    private func handler(data: CMAccelerometerData?, error: Error?) {
        guard let accelerationData = data else {
            DLog("Error receiving accelerometer data: \(error!)")
            return
        }

        handleData(accelerationData.acceleration)
    }

    private func handleData(_ acceleration: CMAcceleration) {
        if initialXAccel == nil || initialYAccel == nil {
            initialXAccel = acceleration.x
            initialYAccel = acceleration.y
        }

        let deltaX = (acceleration.x - initialXAccel) * scale
        let deltaY = (acceleration.y - initialYAccel) * scale
        DLog("Deltas: \(deltaX), \(deltaY)")
        let nextPoint = CGPoint(x: touch.x+CGFloat(deltaX), y: touch.y+CGFloat(deltaY))

        path.addLine(to: nextPoint)
        touch = nextPoint

        sketchView.setNeedsDisplay()
    }

}

// MARK: - Action

extension SketchViewController {

    @IBAction func didPressDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didPressUndo(_ sender: Any) {
        sketchView.undo()
    }

    @IBAction func didPressSave(_ sender: Any) {
        guard let image = UIImage(view: sketchView) else {
            DLog("Could not convert image to view")
            return
        }

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    @IBAction func didPressRedo(_ sender: Any) {
        sketchView.redo()
    }

}

// MARK: - UITapGestureRecognizer

extension SketchViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchDown = touches.first else {
            return
        }

        touch = touchDown.location(in: view)
        beginGettingData()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endGettingData()
    }

}

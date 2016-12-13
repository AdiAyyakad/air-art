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

    let scale = 20.0
    var path = UIBezierPath()
    var touch: CGPoint = .zero

    #if DEBUG
    var presentedTutorial = false
    #endif

    let motionManager = CMMotionManager()

    var initialXAccel: Double!
    var initialYAccel: Double!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMotion()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        #if DEBUG
            if !presentedTutorial {
                presentedTutorial = true
                presentTutorial()
            }
        #else
            if !UserDefaults.standard.bool(forKey: UserDefaultsKeys.PresentedTutorial.rawValue) {
                presentTutorial()
                UserDefaults.standard.set(true, forKey: UserDefaultsKeys.PresentedTutorial.rawValue)
            }
        #endif
    }

}

// MARK: - Setup

extension SketchViewController {

    func setupMotion() {
        motionManager.accelerometerUpdateInterval = 0.1
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

        motionManager.startAccelerometerUpdates(to: queue) { [unowned self] data, error in
            guard let accelerationData = data else {
                DLog("Error receiving accelerometer data: \(error!)")
                return
            }

            self.handleData(accelerationData.acceleration)
        }
    }

    func endGettingData() {
        DLog("End getting data")
        initialXAccel = nil
        initialYAccel = nil

        motionManager.stopAccelerometerUpdates()
    }

    private func handleData(_ acceleration: CMAcceleration) {
        if initialXAccel == nil || initialYAccel == nil {
            initialXAccel = acceleration.x
            initialYAccel = acceleration.y
        }

        let deltaX = (acceleration.x - initialXAccel) * scale
        let deltaY = (acceleration.y - initialYAccel) * scale

        let nextPoint = CGPoint(x: touch.x+CGFloat(deltaX), y: touch.y-CGFloat(deltaY))

        path.addLine(to: nextPoint)
        touch = nextPoint

        sketchView.setNeedsDisplay()
    }

    @IBAction func didPressEdit(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Sketch", bundle: nil)
        let NC = storyboard.instantiateViewController(withIdentifier: "SettingsNavigationController") as! UINavigationController
        present(NC, animated: true, completion: nil)
    }

}

// MARK: - Action

extension SketchViewController {

    @IBAction func didPressDone(_ sender: Any) {
        let alert = UIAlertController(title: "Confirmation",
                                      message: "Are you sure you want to save your image?",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: { [unowned self] action in
                                        guard let image = UIImage(view: self.sketchView) else {
                                            DLog("Could not convert image to view")
                                            return
                                        }

                                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }))

        alert.addCancelAction()

        present(alert, animated: true, completion: nil)
    }

    @IBAction func didPressUndo(_ sender: Any) {
        sketchView.undo()
    }

    @IBAction func didPressRedo(_ sender: Any) {
        sketchView.redo()
    }

    @IBAction func didPressClose(_ sender: Any) {
        let alert = UIAlertController(title: "Confirmation",
                                      message: "Are you sure you want to clear your image?",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: { [unowned self] action in
                                        self.sketchView.clear()
        }))

        alert.addCancelAction()

        present(alert, animated: true, completion: nil)
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

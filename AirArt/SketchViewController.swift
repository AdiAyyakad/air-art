//
//  SketchViewController.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/1/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit
import CoreGraphics

class SketchViewController: UIViewController {

    @IBOutlet weak var sketchView: SketchView!

    var lastPoint = CGPoint.zero
    var path = UIBezierPath()
    var paint: Paint { return Paint.currentPaint }
    var swiped = false

    override func viewDidLoad() {
        super.viewDidLoad()

        let pan = UIPanGestureRecognizer(target: self, action: #selector(panDraw(_:)))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1

        path.lineCapStyle = .round
        sketchView.path = path

        sketchView.addGestureRecognizer(pan)
    }

}

// MARK: - Action

extension SketchViewController {

    @IBAction func didPressDone(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

}

// MARK: - UIPanGestureRecognizer

extension SketchViewController {

    func panDraw(_ pan: UIPanGestureRecognizer) {
        let currentPoint = pan.location(in: view)

        switch pan.state {
        case .began:
            lastPoint = currentPoint
            path.move(to: currentPoint)
        case .changed:
            path.addLine(to: currentPoint)
        default:
            break
        }

        sketchView.setNeedsDisplay()
    }

}

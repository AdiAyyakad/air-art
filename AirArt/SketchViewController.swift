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
    var path = UIBezierPath()

    override func viewDidLoad() {
        super.viewDidLoad()

        let pan = UIPanGestureRecognizer(target: self, action: #selector(panDraw(_:)))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1

        sketchView.addGestureRecognizer(pan)
    }

}

// MARK: - Action

extension SketchViewController {

    @IBAction func didPressDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didPressUndo(_ sender: Any) {
        let image = UIImage(view: sketchView)
        UIImageWriteToSavedPhotosAlbum(image,nil,nil,nil)
        sketchView.undo()
    }

    @IBAction func didPressRedo(_ sender: Any) {
        sketchView.redo()
    }

}

// MARK: - UIPanGestureRecognizer

extension SketchViewController {

    func panDraw(_ pan: UIPanGestureRecognizer) {
        let currentPoint = pan.location(in: view)

        switch pan.state {
        case .began:
            path = UIBezierPath()
            path.lineCapStyle = .round

            sketchView.add(path: path, paint: Paint.currentPaint)
            path.move(to: currentPoint)
        case .changed:
            path.addLine(to: currentPoint)
        default:
            break
        }

        sketchView.setNeedsDisplay()
    }

}

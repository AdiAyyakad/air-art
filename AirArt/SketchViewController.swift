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

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    var lastPoint = CGPoint.zero
    var paint: Paint { return Paint.currentPaint }
    var swiped = false

}

// MARK: - Action

extension SketchViewController {

    @IBAction func didPressDone(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

}

// MARK: - UIPanGestureRecognizer

extension SketchViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }

    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }

        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))

        context.move(to: fromPoint)
        context.addLine(to: toPoint)

        context.setLineCap(.round)
        context.setLineWidth(paint.brushSize)
        context.setStrokeColor(paint.getUIColor().cgColor)
        context.setBlendMode(.normal)

        context.strokePath()

        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = paint.alpha
        UIGraphicsEndImageContext()

    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: view)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if !swiped {
            // draw a single point
            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
        }

        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: CGRect(x: 0,
                                             y: 0,
                                             width: view.frame.size.width,
                                             height: view.frame.size.height),
                                  blendMode: .normal,
                                  alpha: 1.0)
        tempImageView.image?.draw(in: CGRect(x: 0,
                                               y: 0,
                                               width: view.frame.size.width,
                                               height: view.frame.size.height),
                                        blendMode: .normal,
                                        alpha: paint.alpha)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        tempImageView.image = nil
    }

}

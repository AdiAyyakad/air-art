//
//  BlockerView.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/5/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

/**
 * UIView subclass that captures all touches and passes it to a subview.
 * If the touch cannot be captured by a subview, then the touch is removed.
 */
class BlockerView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if subview.frame.contains(point) && subview.isUserInteractionEnabled {
                DLog("Captured by subview")
                return true
            }
        }

        DLog("Not captured in subviews")
        return false
    }
}

//
//  ViewToImageConverter.swift
//  AirArt
//
//  Created by Alex Selengut on 12/6/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}

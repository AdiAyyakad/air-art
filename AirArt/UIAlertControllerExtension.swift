//
//  UIAlertViewControllerExtension.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/8/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import UIKit

extension UIAlertController {

    func addCancelAction(completion handler: ((UIAlertAction) -> ())? = nil) {
        addAction(UIAlertAction(title: "Cancel",
                                style: .cancel,
                                handler: handler))
    }

}

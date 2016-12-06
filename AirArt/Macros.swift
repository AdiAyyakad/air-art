//
//  Macros.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/5/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import Foundation

func DLog(_ msg: String, _ filename: String = #file, _ function: String = #function, _ line: Int = #line) {
    guard let file = filename.components(separatedBy: "/").last else {
        NSLog("[\(filename)):\(line)] \(function) - \(msg)")
        return
    }

    NSLog("[\(file)):\(line)] \(function) - \(msg)")
}

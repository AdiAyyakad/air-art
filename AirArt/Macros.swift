//
//  Macros.swift
//  AirArt
//
//  Created by Aditya Ayyakad on 12/5/16.
//  Copyright © 2016 Adi. All rights reserved.
//

import Foundation

func DLog(_ msg: String, _ filePath: String = #file, _ function: String = #function, _ line: Int = #line) {

    #if DEBUG
        guard let filename = filePath.components(separatedBy: "/").last else {
            NSLog("[\(filePath):\(line)] \(function) - \(msg)")
            return
        }

        guard let file = filename.components(separatedBy: ".").first else {
            NSLog("[\(filename):\(line)] \(function) - \(msg)")
            return
        }

        NSLog("[\(file):\(line)] \(function) - \(msg)")
    #endif

}

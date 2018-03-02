//
//  FXVersionCheckLog.swift
//  FXVersionCheckDemo
//
//  Created by bailun on 2018/3/1.
//  Copyright © 2018年 bailun. All rights reserved.
//

import Foundation

// MARK: - Log and decorate FXVersionCheck-specific messages to the console.
struct FXVersionCheckLog {
    
    @discardableResult
    init(_ message: String) {
        print("[FXVersionCheck] \(message)")
    }
    
}

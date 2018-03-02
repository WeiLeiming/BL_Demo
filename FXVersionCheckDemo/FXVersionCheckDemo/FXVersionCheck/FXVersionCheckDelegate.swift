//
//  FXVersionCheckDelegate.swift
//  FXVersionCheckDemo
//
//  Created by bailun on 2018/3/1.
//  Copyright © 2018年 bailun. All rights reserved.
//

import Foundation

// MARK: - FXVersionCheckDelegate Protocol
protocol FXVersionCheckDelegate: NSObjectProtocol {
    
    /// User presented with update dialog.
    func versionCheckDidShowUpdateDialog(alertType: FXVersionCheckManager.FXAlertType)
    
    /// User did click on button that launched App Store.app.
    func versionCheckUserDidLaunchAppStore()
    
    /// User did click on button that skips version update.
    func versionCheckUserDidSkipVersion()
    
    /// User did click on button that cancels update dialog.
    func versionCheckUserDidCancel()
    
    /// Siren failed to perform version check (may return system-level error).
    func versionCheckDidFailVersionCheck(error: Error)
    
    /// Siren performed version check and did not display alert.
//    func versionCheckDidDetectNewVersionWithoutAlert(message: String, updateType: UpdateType)
    
    /// Siren performed version check and latest version is installed.
    func versionCheckLatestVersionInstalled()
    
}

// MARK: - SirenDelegate Protocol Extension

extension FXVersionCheckDelegate {
    
    func versionCheckDidShowUpdateDialog(alertType: FXVersionCheckManager.FXAlertType) {
        printMessage()
    }
    
    func versionCheckUserDidLaunchAppStore() {
        printMessage()
    }
    
    func versionCheckUserDidSkipVersion() {
        printMessage()
    }
    
    func versionCheckUserDidCancel() {
        printMessage()
    }
    
    func versionCheckDidFailVersionCheck(error: Error) {
        printMessage()
    }
    
//    func sirenDidDetectNewVersionWithoutAlert(message: String, updateType: UpdateType) {
//        printMessage()
//    }
    
    func sirenLatestVersionInstalled() {
        printMessage()
    }
    
    private func printMessage(_ function: String = #function) {
        FXVersionCheckLog("The default implementation of \(function) is being called. You can ignore this message if you do not care to implement this method in your `SirenDelegate` conforming structure.")
    }
    
}

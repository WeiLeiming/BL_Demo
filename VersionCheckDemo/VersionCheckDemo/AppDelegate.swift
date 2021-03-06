//
//  AppDelegate.swift
//  VersionCheckDemo
//
//  Created by bailun on 2018/2/7.
//  Copyright © 2018年 bailun. All rights reserved.
//

import UIKit
import Siren

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configVersionCheck()
        
        return true
    }
    
    fileprivate func configVersionCheck() {
        let siren = Siren.shared
        /*
        siren.alertMessaging = SirenAlertMessaging(updateTitle: "New Fancy Title",
                                                   updateMessage: "New message goes here!",
                                                   updateButtonMessage: "Update Now, Plz!?",
                                                   nextTimeButtonMessage: "OK, next time it is!",
                                                   skipVersionButtonMessage: "Please don't push skip, please don't!")
        */
        // 提醒样式，全局设置
        siren.alertType = .option
        // 大版本、小版本、补丁、修订版
        siren.majorUpdateAlertType = .force
        siren.minorUpdateAlertType = .option
        siren.patchUpdateAlertType = .skip
        siren.revisionUpdateAlertType = .skip
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        Siren.shared.checkVersion(checkType: .immediately)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        Siren.shared.checkVersion(checkType: .daily)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


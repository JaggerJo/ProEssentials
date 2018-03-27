//
//  AppDelegate.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 18.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Cocoa
import macOSThemeKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var internetIndicator = InternetIndicator()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        ThemeManager.darkTheme.apply()
        createIndicators()
    }
    
    func createIndicators() {
        internetIndicator.create()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        internetIndicator.destroy()
    }
}

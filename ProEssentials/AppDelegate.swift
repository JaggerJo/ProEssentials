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
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {
    var internetIndicator = InternetIndicator()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSUserNotificationCenter.default.delegate = self
        applyTheme()
        createIndicators()
    }

    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    func createIndicators() {
        internetIndicator.create()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        internetIndicator.destroy()
    }
    
    func applyTheme() {
        if SettingsManager().loadOrFallback(type: GeneralSettings.self).useDarkMode {
            ThemeManager.darkTheme.apply()
        }
        else {
            ThemeManager.lightTheme.apply()
        }
    }
}

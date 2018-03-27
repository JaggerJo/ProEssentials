//
//  InternetIndicator.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 27.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Foundation
import Cocoa
import PlainPing

public class InternetIndicator : Indicator {
    private var indicator: NSStatusItem? = nil;
    private var timer: Timer? = nil;
    private var internetAvailiable: Bool? = nil;
    private var settings: InternetIndicatorSettings? = nil;
    
    public func create() {
        loadSettings()
        createIndicator()
        startConnectionChecking()
    }
    
    public func destroy() {
        destroyIndicator()
    }
    
    private func loadSettings() {
        settings = SettingsManager().loadOrFallback(type: InternetIndicatorSettings.self)
    }
    
    private func createIndicator() {
        indicator = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength);
        if let button = indicator?.button {
            button.image = NSImage(named: NSImage.Name("internet_indicator_undefined"))
        }
    }
    
    private func destroyIndicator() {
        indicator = nil;
    }
    
    private func startConnectionChecking() {
        timer = Timer.scheduledTimer(
            timeInterval: settings!.pingInterval,
            target: self,
            selector: #selector(checkConnection),
            userInfo: nil,
            repeats: true)
    }
    
    @objc
    private func checkConnection() {
        PlainPing.ping(settings!.host, withTimeout: settings!.pingTimeout) {
            (timeElapsed:Double?, error:Error?) in
            
            if timeElapsed != nil {
                self.update(state: true)
                return;
            }
            
            if error != nil {
                self.update(state: false)
                return;
            }
            
            self.update(state: nil)
        }
    }
    
    private func update(state: Bool?) {
        // nothing changed
        if (self.internetAvailiable == state) {
            return;
        }
        
        self.internetAvailiable = state;
        
        if let button = self.indicator?.button {
            // nil
            if (state == nil) {
                button.image = NSImage(named: NSImage.Name("internet_indicator_undefined"))
            }
            // true/false
            else {
                button.image = NSImage(named: NSImage.Name(
                    internetAvailiable!
                        ? "internet_indicator_green"
                        : "internet_indicator_red"
                ))
                
                if settings!.showNotifications == true {
                    showNotification(state: state!);
                }
            }
        }
    }
    
    private func showNotification(state: Bool) {
        let notification = NSUserNotification()
        notification.identifier = UUID().uuidString
        notification.title = state
            ? "Internet Availiable"
            : "Internet Unavailiable"
        
        notification.soundName = NSUserNotificationDefaultSoundName
        notification.contentImage = NSImage(named: NSImage.Name(
            state
                ? "internet_indicator_green"
                : "internet_indicator_red"
        ))
        
        // Manually display the notification
        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.deliver(notification)
    }
}

//
//  InternetIndicatorSettings.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 27.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Foundation

public class InternetIndicatorSettings : Setting {
    public var filename: String = "internet_indicator_settings.json"
    
    public var host: String;
    public var pingInterval: Double;
    public var pingTimeout: Double;
    public var showNotifications: Bool;
    
    required public init() {
        host = "google.com"
        pingInterval = 1
        pingTimeout = 1
        showNotifications = true;
    }
}

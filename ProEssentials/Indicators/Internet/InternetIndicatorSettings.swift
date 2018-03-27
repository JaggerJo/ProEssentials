//
//  InternetIndicatorSettings.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 27.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Foundation

public class InternetIndicatorSettings : Setting {
    public let filename: String = "internet_indicator_settings.json"
    
    public let host: String;
    public let pingInterval: Double;
    public let pingTimeout: Double;
    public let showNotifications: Bool;
    
    required public init() {
        host = "google.com"
        pingInterval = 1
        pingTimeout = 1
        showNotifications = true;
    }
}

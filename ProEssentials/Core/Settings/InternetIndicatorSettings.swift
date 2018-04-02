//
//  InternetIndicatorSettings.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 27.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Foundation
import ProEssentials_Lib

public class InternetIndicatorSettings : Setting {
    public var filename: String = "internet_indicator_settings.json"
    
    public var host: String;
    public var pingInterval: Double;
    public var pingTimeout: Double;
    public var showNotifications: Bool;
    
    required public init() {
        host = "1.1.1.1"
        pingInterval = 2
        pingTimeout = 2
        showNotifications = true;
    }
}

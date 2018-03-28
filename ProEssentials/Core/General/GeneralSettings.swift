//
//  GeneralSettings.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 28.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Foundation

class GeneralSettings : Setting {
    public var filename: String = "general_settings.json"
    
    public var useDarkMode: Bool
    
    required public init() {
        useDarkMode = false
    }
}

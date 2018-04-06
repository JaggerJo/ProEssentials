//
//  GeneralViewController.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 28.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Foundation
import Cocoa
import Bond
import ReactiveKit
import ProEssentials_Lib

class GeneralViewController : NSViewController {
    @IBOutlet var transparentCheckbox: NSButton!
    @IBOutlet var themeSegmentedButton: NSSegmentedControl!
    
    override func viewDidLoad() {
        loadSettings()
    }
    
    func loadSettings() {
        let settings = SettingsManager().loadOrFallback(type: GeneralSettings.self)
        
        // Theme Selection
        themeSegmentedButton.setSelected(true, forSegment: settings.theme.toSegmentIndex())
        _ = themeSegmentedButton.reactive.controlEvent { signal in
            settings.theme = ApplicationTheme.fromSegmentIndex(index: signal.indexOfSelectedItem)
        }
        
        // Theme Transparency
        transparentCheckbox.state = settings.transcluent
            ? .on
            : .off
        
        _ = transparentCheckbox.reactive.controlEvent { signal in
            settings.transcluent = signal.state == .on
                ? true
            : false
        }
    }
}

fileprivate extension ApplicationTheme {
    func toSegmentIndex() -> Int {
        switch self {
            case .system:   return 0
            case .dark:     return 1
            case .light:    return 2
        }
    }
    static func fromSegmentIndex(index: Int) -> ApplicationTheme {
        switch index {
            case 0:     return .system
            case 1:     return .dark
            case 2:     return .light
            default:    return .system
        }
    }
}

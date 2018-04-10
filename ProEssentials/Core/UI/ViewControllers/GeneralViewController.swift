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

fileprivate func themeFromIndex(index: Int) -> ApplicationTheme {
    switch index {
        case 0: return .system
        case 1: return .dark
        case 2: return .light
        default: return .system
    }
}

fileprivate func indexFromTheme(theme: ApplicationTheme) -> Int {
    switch theme {
        case .system: return 0
        case .dark: return 1
        case .light: return 2
        default: return 0
    }
}

class GeneralViewController : NSViewController {
    public var settings: GeneralSettings?
    
    @IBOutlet var useTranscluentBtn: NSButton!
    @IBOutlet var themeSegBtn: NSSegmentedControl!
    
    override func viewDidLoad() {
        loadSettings()
        setupBindings()
    }
    
    func loadSettings() {
        settings = SettingsManager().loadOrFallback(type: GeneralSettings.self)
        
        //useDarkThemeBtn.state = settings?.useDarkMode == true
        //    ? .on
        //    : .off
    }
    
    func setupBindings() {
        func saveCurrent() {
            do {
                try SettingsManager().save(setting: self.settings!)
            }
            catch {
                print(error)
            }
        }
        
        useTranscluentBtn.reactive.controlEvent.observe(with: {
            event in
        
            self.settings?.transcluent = event.element?.state == .on
                ? true
                : false
            
            saveCurrent()
            reloadTheme.next(true)
        })
        
        
        
        themeSegBtn.reactive.controlEvent.observe(with: { param in
            print("changed theme")
            let theme = themeFromIndex(index: (param.element?.selectedSegment)!)
            self.settings?.theme = theme
            
            saveCurrent()
            reloadTheme.next(true)
        })
        
        
        
    }
}

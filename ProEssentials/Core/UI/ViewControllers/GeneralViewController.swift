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
    public var settings: GeneralSettings?
    
    @IBOutlet var useDarkThemeBtn: NSButton!
    
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
        _ = useDarkThemeBtn.reactive.controlEvent.observe(with: {
            event in
        
            //self.settings?.useDarkMode = event.element?.state == .on
            //    ? true
            //    : false
            
            do {
                try SettingsManager().save(setting: self.settings!)
            }
            catch {
                print(error)
            }
        })
    }
}
